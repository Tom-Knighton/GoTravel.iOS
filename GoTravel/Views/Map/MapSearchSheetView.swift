//
//  MapSearchSheetView.swift
//  GoTravel
//
//  Created by Tom Knighton on 20/12/2023.
//

import SwiftUI
import GoTravel_Models
import CoreLocation
import Turf
import WrappingHStack

public struct MapSheetSearchBar: View {
    
    @Binding public var text: String
    
    public var body: some View {
        HStack {
            Image(systemName: Icons.location_magnifyingglass)
            TextField(Strings.Map.SearchSheetSearch, text: $text)
        }
        .foregroundStyle(.gray)
        .padding(.vertical, 8)
        .padding(.horizontal, 5)
        .background(Color(.quaternaryLabel))
        .clipShape(.rect(cornerRadius: 10))
        .padding([.horizontal, .bottom])
    }
}

public struct MapSheetSearchResults: View {
    
    @Binding public var searchResults: [StopPoint]
    
    public var body: some View {
        ScrollView {
            VStack {
                ForEach(searchResults, id: \.stopPoint.stopPointId) { result in
                    MapSheetSearchResultItem(item: result)
                }
                Spacer()
            }
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

public struct MapSheetSearchResultItem: View {
    
    public let item: StopPoint
    
    @State private var distanceTo: Double? = nil
    @State private var city: String? = nil
    @State private var distanceIsYards: Bool = false
    
    private let isBusLikeFlag: String = "isBusLike"
    
    init(item: StopPoint) {
        self.item = item

    }
    
    public var body: some View {
        VStack(alignment: .leading) {

            HStack(spacing: 2) {
                Text(item.stopPoint.stopPointName)
                    .bold()
                if case .bus(let busStopPoint) = item {
                    if let indication = busStopPoint.busStopLetter ?? busStopPoint.busStopIndicator {
                        Text(Strings.Map.BusStopIndication(indication))
                            .bold()
                    }
                }
                Spacer()
            }
            .accessibilityElement()
            .accessibilityAddTraits(.isStaticText)
            .accessibilityLabel(item.stopPoint.stopPointName)
            
            HStack(spacing: 2) {
                if let distanceTo {
                    Text(Strings.Map.Distance(String(format: "%0.1f", distanceTo), measurement: self.distanceIsYards ? "yds" : "mi"))
                }
                if distanceTo != nil && city != nil {
                    Text("•")
                        .accessibilityHidden()
                }
                if let city {
                    Text(city)
                }
            }
            .font(.caption)
            
            
            WrappingHStack(alignment: .leading) {
                lineModesView()
            }
            
            bikeLineModesView()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 16))
        .accessibilityElement(children: .contain)
        .accessibilityLabel(item.stopPoint.stopPointName)
        .task {
            if let coordinate = LocationManager.shared.manager.location?.coordinate {
                let distance = item.stopPoint.stopPointCoordinate.coordinates.distance(to: coordinate)
                
                if distance < 321.869 { //0.2 miles
                    self.distanceTo = Double(Int(distance / 1760))
                    self.distanceIsYards = true
                } else {
                    self.distanceTo = distance / 1690
                    self.distanceIsYards = false
                }
            }
            
            let coord = item.stopPoint.stopPointCoordinate.coordinates
            let lat = coord.latitude
            let lon = coord.longitude
            let loc = try? await CLGeocoder().reverseGeocodeLocation(.init(latitude: lat, longitude: lon))
            city = loc?.first?.locality
        }
    }
    
    
    private func getLineModesToDisplay() -> [LineMode] {
        let lineModesToDisplay = self.item.stopPoint.lineModes.filter { !$0.hasFlag("IsBusLike") }
        
        return lineModesToDisplay
    }
    
    private func getBusLinesToDisplay() -> [String] {
        let busLines = self.item.stopPoint.lineModes.filter { $0.hasFlag("IsBusLike") }
        
        return busLines.flatMap { $0.lines.compactMap { $0.lineName } }
    }
    
    @ViewBuilder
    private func lineModesView() -> some View {
        let normalModes = getLineModesToDisplay()
        ForEach(normalModes, id: \.lineModeName) { lineMode in
            AsyncImage(url: URL(string: lineMode.branding.lineModeLogoUrl)) { img in
                img
                    .resizable()
                    .frame(width: 20, height: 20)
                    .shadow(radius: 3)
                    .accessibilityElement()
                    .accessibilityLabel(lineMode.lineModeName)
            } placeholder: {
                EmptyView()
             }
        }
        
        let bus = getBusLinesToDisplay()
        if !bus.isEmpty {
            if !normalModes.isEmpty {
                Divider()
            }
            ForEach(bus, id: \.self) { busLine in
                Text(busLine)
                    .font(.footnote)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.red)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(radius: 3)
                    .accessibilityLabel(Strings.Accessibility.MapLineRoute(busLine))
            }
        }
    }
    
    @ViewBuilder
    private func bikeLineModesView() -> some View {
        VStack {
            let bikeLineModes = self.item.stopPoint.lineModes.filter { $0.hasFlag("IsBikeLike") }
            if bikeLineModes.isEmpty == false {
                WrappingHStack {
                    ForEach(bikeLineModes, id: \.lineModeName) { bikeMode in
                        HStack {
                            AsyncImage(url: URL(string: bikeMode.branding.lineModeLogoUrl)) { img in
                                img
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .accessibilityElement()
                                    .accessibilityLabel(bikeMode.lineModeName)
                            } placeholder: {
                                EmptyView()
                            }
                            Text(bikeMode.lineModeName)
                        }
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(.red)
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(radius: 3)
                    }
                }
            }
            
            if case .bike(let bikeStopPoint) = item {
                Spacer().frame(height: 8)
                HStack {
                    if bikeStopPoint.bikesRemaining > 0 {
                        Label(String(describing: bikeStopPoint.bikesRemaining), systemImage: Icons.bike_circle)
                            .accessibilityLabel(Strings.Accessibility.MapBikesRemaining(bikeStopPoint.bikesRemaining))
                    }
                    
                    if bikeStopPoint.bikesRemaining > 0 && bikeStopPoint.eBikesRemaining > 0 {
                        Divider()
                    }
                    
                    if bikeStopPoint.eBikesRemaining > 0 {
                        Label(String(describing: bikeStopPoint.eBikesRemaining), systemImage: Icons.bike_circle_fill)
                            .foregroundStyle(.green)
                            .accessibilityLabel(Strings.Accessibility.MapEBikesRemaining(bikeStopPoint.eBikesRemaining))
                    }
                }
            }
        }
    }
}

#Preview {
    MapSheetSearchResultItem(item: StopPoint.train(TrainStopPoint(stopPointId: "001", stopPointName: "Bow Church", stopPointCoordinate: .init(CLLocationCoordinate2D(latitude: 51.524172, longitude: -0.039732)), stopPointHub: nil, stopPointParentId: nil, children: [], lineModes: [.init(lineModeName: "Line Mode 1", lines: [], primaryAreaName: "UK", branding: .init(lineModeLogoUrl: "https://cdn.tomk.online/cdn/GoTravelBranding/dlr.png", lineModeBackgroundColour: "#000000", lineModePrimaryColour: "#ffffff", lineModeSecondaryColour: nil), flags: ["isBusLike"]),.init(lineModeName: "Line Mode 2", lines: [], primaryAreaName: "UK", branding: .init(lineModeLogoUrl: "https://cdn.tomk.online/cdn/GoTravelBranding/dlr.png", lineModeBackgroundColour: "#000000", lineModePrimaryColour: "#ffffff", lineModeSecondaryColour: nil), flags: [])])))
}
