//
//  JourneyMapView.swift
//  GoTravel
//
//  Created by Tom Knighton on 09/02/2024.
//

import SwiftUI
import MapKit
import GoTravel_Models
import Turf

public struct JourneyMapView: View {
    
    var journey: Journey
    var hideControls: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var scrollId: Int?
    @State private var camera: MapCameraPosition = .automatic
    
    init(journey: Journey, miniView: Bool = false, startAtLegIndex: Int = 0) {
        self.journey = journey
        self.hideControls = miniView
        self._scrollId = State(wrappedValue: startAtLegIndex)
    }
    
    public var body: some View {
        ZStack {
            Map(position: $camera, interactionModes: hideControls ? [] : .all) {
                ForEach(Array(journey.journeyLegs.enumerated()), id: \.offset) { index, leg in
                    MapPolyline(coordinates: leg.legDetails.lineString.coordinates)
                        .stroke(brandingColor(leg).opacity(index == scrollId ? 1 : 0.7), style: .init(lineWidth: index == scrollId ? 12 : 8, lineCap: .round))
                }
                ForEach(journey.journeyLegs, id: \.beginLegAt) { leg in
                    
                    if let firstStop = leg.startAtStop {
                        if let coord = leg.legDetails.lineString.closestCoordinate(to: firstStop.stopCoordinate.coordinates) {
                            Annotation(firstStop.stopPointName, coordinate: coord.coordinate) {
                                Circle()
                                    .stroke(.black, style: .init(lineWidth: 2))
                                    .fill(.white)
                            }
                        }
                    }
                    
                    ForEach(leg.legDetails.stopPoints, id: \.stopPointId) { stop in
                        let coord = leg.legDetails.lineString.closestCoordinate(to: stop.stopCoordinate.coordinates)?.coordinate as? LocationCoordinate2D
                        if let coord {
                            Annotation(stop.stopPointName, coordinate: coord) {
                                Circle()
                                    .stroke(.black, style: .init(lineWidth: 1))
                                    .fill(.white)
                            }
                        }
                    }
                }
                
                UserAnnotation()
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
                MapPitchToggle()
            }
            .if(!hideControls) { map in
                map
                    .safeAreaPadding(.top, 50)
                    .safeAreaPadding(.trailing, 10)
            }
            .mapControlVisibility(hideControls ? .hidden : .visible)
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
            
            if !hideControls {
                MapControls()
            }
        }
        .onChange(of: self.scrollId, initial: true) { _, value in
            guard let value else {
                return
            }
            
            let leg = journey.journeyLegs[value]
            
            if hideControls {
                let coords = journey.journeyLegs.flatMap { $0.legDetails.lineString.coordinates }
                self.camera = .region(regionToFit(coords))
            } else {
                withAnimation {
                    self.camera = cameraToFit(leg.legDetails.lineString.coordinates)
                }
            }
        }
    }
    
    @ViewBuilder
    private func MapControls() -> some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { self.dismiss() }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Material.thick)
                        Image(systemName: Icons.cross)
                            .font(Font.body.weight(.bold))
                    }
                    .frame(width: 45, height: 45)
                }
                Spacer().frame(width: 14)
            }
            Spacer()
            
            SingleAxisGeometryReader { width in
                ScrollViewReader { reader in
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(Array(journey.journeyLegs.enumerated()), id: \.offset) { index, leg in
                                VStack {
                                    Text(leg.legDetails.summary)
                                        .bold()
                                        .fontDesign(.rounded)
                                    
                                    if let detailed = leg.legDetails.detailedSummary, detailed != leg.legDetails.summary {
                                        Text(detailed)
                                            .font(.subheadline)
                                            .fontDesign(.rounded)
                                            .fontWeight(.light)
                                    }
                                }
                                .padding(.horizontal, 8)
                                .frame(minWidth: abs(width - 32), maxWidth: abs(width - 32), minHeight: 100)
                                .background(Material.thin)
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(radius: 3)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.horizontal, 16)
                    .scrollIndicators(.hidden)
                    .scrollPosition(id: $scrollId)
                    .onChange(of: self.scrollId, initial: true) { _, new in
                        if let new {
                            reader.scrollTo(new)
                        }
                    }
                }
               
            }

            Spacer().frame(height: 32)
        }

    }
    
    private func brandingColor(_ leg: JourneyLeg) -> Color {
        switch leg.legDetails.lineMode.lineModeId {
        case "walking":
            return .gray
        case "cycle":
            return .gray
        default:
            if let line = leg.legDetails.lineMode.lines.first,
               let hex = line.linePrimaryColour, let colour = Color(hex: hex) {
                return colour
            } else {
                return Color(hex: leg.legDetails.lineMode.branding.lineModePrimaryColour) ?? .red
            }
        }
    }
    
    private func regionToFit(_ coords: [CLLocationCoordinate2D]) -> MKCoordinateRegion {
        var minLat = 90.0
        var maxLat = -90.0
        var minLon = 180.0
        var maxLon = -180.0

        for coordinate in coords {
            minLat = min(minLat, coordinate.latitude)
            maxLat = max(maxLat, coordinate.latitude)
            minLon = min(minLon, coordinate.longitude)
            maxLon = max(maxLon, coordinate.longitude)
        }


        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.1, longitudeDelta: (maxLon - minLon) * 1.1)
        return .init(center: center, span: span)
    }
    
    private func cameraToFit(_ coords: [CLLocationCoordinate2D]) -> MapCameraPosition {
        var minLat = 90.0
        var maxLat = -90.0
        var minLon = 180.0
        var maxLon = -180.0

        for coordinate in coords {
            minLat = min(minLat, coordinate.latitude)
            maxLat = max(maxLat, coordinate.latitude)
            minLon = min(minLon, coordinate.longitude)
            maxLon = max(maxLon, coordinate.longitude)
        }


        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
        
        let latDelta = maxLat - minLat
        let lonDelta = maxLon - minLon
        let averageLat = (minLat + maxLat) / 2
        let metersPerDegreeLat = 111320 * cos(averageLat * .pi / 180)
        let metersPerDegreeLon = 111320 * cos(averageLat * .pi / 180)
        let widthInMeters = lonDelta * metersPerDegreeLon
        let heightInMeters = latDelta * metersPerDegreeLat

        let fieldOfView = 60.0 * .pi / 180
        let aspectRatio = 1.0

        let maxDimension = max(widthInMeters, heightInMeters / aspectRatio)
        let cameraDistance = (maxDimension / 2) / tan(fieldOfView / 2)
        
        return .camera(.init(centerCoordinate: center, distance: cameraDistance * 6, pitch: 30))
    }
}

#Preview {
    JourneyMapView(journey: PreviewDataJourney.PreviewJourneyResponse().journeyOptions.first!)
}
