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
    
    @Environment(GlobalViewModel.self) private var globalVM
    
    @Binding public var isNearby: Bool
    @Binding public var searchResults: [StopPoint]
    @Binding public var scrollToId: String?
    
    public var body: some View {
        ScrollViewReader { reader in
            ScrollView {
                LazyVStack {
                    if isNearby {
                        Text(Strings.Map.SearchSheetNearby)
                            .font(.title.bold())
                            .fontDesign(.rounded)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    ForEach(searchResults, id: \.stopPoint.stopPointId) { result in
                        MapSheetSearchResultItem(item: result, isSelected: self.scrollToId == result.stopPoint.stopPointId)
                            .id(result.stopPoint.stopPointId)
                            .onTapGesture {
                                self.globalVM.addToCurrentNavStack(StopPointNavModel(stopPointId: result.stopPoint.stopPointId))
                            }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 12)
            }
            .onChange(of: self.scrollToId) { _, newValue in
                if let newValue {
                    withAnimation {
                        reader.scrollTo(newValue, anchor: .top)
                    }
                }
            }
        }
        
    }
}

public struct MapSheetSearchResultItem: View {
    
    public let item: StopPoint
    private let isSelected: Bool

    @State private var distanceTo: Double? = nil
    @State private var city: String? = nil
    @State private var distanceIsYards: Bool = false
    

    private let isBusLikeFlag: String = "isBusLike"
    
    
    init(item: StopPoint, isSelected: Bool) {
        self.item = item
        self.isSelected = isSelected
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
            
            
            LineModesView(stop: self.item)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.regularMaterial)
        .if(isSelected, content: { view in
            view.background(Color.yellow)
        })
        .clipShape(.rect(cornerRadius: 16))
        .shadow(radius: 3)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(item.stopPoint.stopPointName)
        .task {
            if let coordinate = LocationManager.shared.manager.location?.coordinate {
                let distance = item.stopPoint.stopPointCoordinate.coordinates.distance(to: coordinate)
                
                if distance < 321.869 { //0.2 miles
                    self.distanceTo = Double(distance * 0.9144)
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
    
    
}
//
//#Preview {
//    MapSheetSearchResultItem(item: StopPoint.train(TrainStopPoint(stopPointId: "001", stopPointName: "Bow Church", stopPointCoordinate: .init(CLLocationCoordinate2D(latitude: 51.524172, longitude: -0.039732)), stopPointHub: nil, stopPointParentId: nil, children: [], lineModes: [.init(lineModeName: "Line Mode 1", lines: [], primaryAreaName: "UK", branding: .init(lineModeLogoUrl: "https://cdn.tomk.online/cdn/GoTravelBranding/dlr.png", lineModeBackgroundColour: "#000000", lineModePrimaryColour: "#ffffff", lineModeSecondaryColour: nil), flags: ["isBusLike"]),.init(lineModeName: "Line Mode 2", lines: [], primaryAreaName: "UK", branding: .init(lineModeLogoUrl: "https://cdn.tomk.online/cdn/GoTravelBranding/dlr.png", lineModeBackgroundColour: "#000000", lineModePrimaryColour: "#ffffff", lineModeSecondaryColour: nil), flags: [])])))
//}
