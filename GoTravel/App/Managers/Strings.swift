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
    }
}

public struct Icons {
    public static let gear: String = "gear"
    public static let arrow_right: String = "arrow.right"
    public static let location_slash = "location.slash"
    public static let cross_circle_fill = "xmark.circle.fill"
    public static let map = "map"
    public static let bike = "bicycle"
    public static let train = "tram"
    public static let bus = "bus"
    public static let location = "location"
    public static let location_magnifyingglass = "location.magnifyingglass"
}
