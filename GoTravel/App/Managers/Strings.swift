//
//  Strings.swift
//  GoTravel
//
//  Created by Tom Knighton on 07/10/2023.
//

import SwiftUI

public struct Strings {
    
    public struct Navigation {
        public static let MapTab: LocalizedStringKey = "MapTab"
    }
    
    public struct Map {
        public static let LocationDisabled: LocalizedStringKey = "LocationDisabled"
        public static let EnableLocationStopPoints: LocalizedStringKey = "StopPointsEnableLocation"
        public static let HintSearchHere: LocalizedStringKey = "Map:Hint:SearchHere"
        public static let HintSearchHereText: LocalizedStringKey = "Map:Hint:SearchHereText"
        
        public static let LineModeFilterTitle: LocalizedStringKey = "Map:LineModeFilters:Title"
        public static let LineModeFilterSubtitle: LocalizedStringKey = "Map:LineModeFilters:Subtitle"
        public static let LineModeFilterNearby: LocalizedStringKey = "Map:LineModeFilters:Nearby"
        public static let LineModeFilterOthers: LocalizedStringKey = "Map:LineModeFilters:Others"
        
        public static let SearchSheetSearch: LocalizedStringKey = "Map:SearchSheet:Search"
        public static let SearchSheetNearby: LocalizedStringKey = "Map:SearchSheet:Nearby"
        
        public static func BusStopIndication(_ indication: String) -> LocalizedStringKey {
            LocalizedStringKey("Map:SearchSheet:BusStopIndication:\(indication)")
        }
        
        public static func Distance(_ distance: String, measurement: String = "miles") -> LocalizedStringKey {
            LocalizedStringKey("Map:Distance:\(distance):\(measurement)")
        }
    }
    
    public struct Errors {
        public static let NoLineModesAPI: LocalizedStringKey = "Errors:NoLineModesFromAPI"
        public static let NoLineModesAPIDescription: LocalizedStringKey = "Errors:NoLineModesFromAPI:Description"
    }
    
    public struct Accessibility {
        
        public static let MapLabelUserSearch: LocalizedStringKey = "Accessibility:Map:UserSearchLabel"
        public static let MapHintUserSearch: LocalizedStringKey = "Accessibility:Map:UserSearchHint"
        public static let MapLabelMapSearch: LocalizedStringKey = "Accessibility:Map:MapSearchLabel"
        public static let MapHintMapSearch: LocalizedStringKey = "Accessibility:Map:MapSearchHint"
        public static let MapLabelFilterSheet: LocalizedStringKey = "Accessibility:Map:FilterSheetLabel"
        public static let MapHintFilterSheet: LocalizedStringKey = "Accessibility:Map:FilterSheetHint"
        
        public static func MapBikesRemaining(_ bikes: Int) -> LocalizedStringKey {
            return "Accessibility:Map:BikesRemainingText:\(bikes)"
        }
        
        public static func MapEBikesRemaining(_ bikes: Int) -> LocalizedStringKey {
            return "Accessibility:Map:EBikesRemainingText:\(bikes)"
        }
        
        public static func MapLineRoute(_ route: String) -> LocalizedStringKey {
            LocalizedStringKey("Accessibility:Map:LineRoute:\(route)")
        }
        
        public static func MapFilterEnables(_ lineMode: String) -> LocalizedStringKey {
            LocalizedStringKey("Accessibility:Map:FilterReEnables:\(lineMode)")
        }
        
        public static func MapFilterHides(_ lineMode: String) -> LocalizedStringKey {
            LocalizedStringKey("Accessibility:Map:FilterHides:\(lineMode)")
        }
    }
}

public struct Icons {
    public static let gear: String = "gear"
    public static let arrow_right: String = "arrow.right"
    public static let arrow_up: String = "arrow.up"
    public static let arrow_down: String = "arrow.down"
    public static let location_slash = "location.slash"
    public static let cross_circle_fill = "xmark.circle.fill"
    public static let map = "map"
    public static let map_circle = "map.circle.fill"
    public static let bike = "bicycle"
    public static let bike_circle = "bicycle.circle"
    public static let bike_circle_fill = "bicycle.circle.fill"
    public static let train = "tram"
    public static let bus = "bus"
    public static let location = "location"
    public static let location_magnifyingglass = "location.magnifyingglass"
    public static let filter = "line.3.horizontal.decrease.circle"
}
