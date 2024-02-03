//
//  Strings.swift
//  GoTravel
//
//  Created by Tom Knighton on 07/10/2023.
//

import SwiftUI
import GoTravel_Models

public struct Strings {
    
    public struct Navigation {
        public static let MapTab: LocalizedStringKey = "Navigation:MapTab"
        public static let JourneyTab: LocalizedStringKey = "Navigation:JourneyTab"
    }
    
    public struct Map {
        public static let LocationDisabled: LocalizedStringKey = "Map:LocationDisabled"
        public static let EnableLocationStopPoints: LocalizedStringKey = "Map:StopPointsEnableLocation"
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
    
    public struct StopPage {
        public static let GetDirectionsButton: LocalizedStringKey = "StopPage:GetDirectionsButton"
        public static let Platform: LocalizedStringKey = "StopPage:Platform"
        public static let Due: LocalizedStringKey = "StopPage:Arrivals:Due"
        public static let Mins: LocalizedStringKey = "StopPage:Arrivals:Mins"
        
        public static let LiveTimes: LocalizedStringKey = "StopPage:Arrivals:LiveTimes"
        public static let CheckBoards: LocalizedStringKey = "StopPage:Arrivals:CheckBoards"
        public static let Towards: LocalizedStringKey = "StopPage:Arrivals:Towards"
        
        public static let Information: LocalizedStringResource = "StopPage:Information"
        public static let WiFi: LocalizedStringKey = "StopPage:Information:WiFi"
        public static let Accessible: LocalizedStringKey = "StopPage:Information:Accessible"
        public static let Address: LocalizedStringKey = "StopPage:Information:Address"
        public static let Toilets: LocalizedStringKey = "StopPage:Information:Toilets"
        public static let Free: LocalizedStringKey = "StopPage:Information:Free"
        public static let StopToiletInfoAlertTitle: LocalizedStringKey = "StopPage:Toilet:AlertTitle"
        
        public struct Accessibility {
            public static let InfoLabel: LocalizedStringKey = "StopPage:Accessibility:InfoLabel"
            
            public static let HasWifiLabel: LocalizedStringKey = "StopPage:Accessibility:HasWifiLabel"
            public static let NoWifiLabel: LocalizedStringKey = "StopPage:Accessibility:NoWifiLabel"
            public static let ViaLiftLabel: LocalizedStringKey = "StopPage:Accessibility:ViaLiftLabel"
            public static let NoViaLiftLabel: LocalizedStringKey = "StopPage:Accessibility:NoViaLiftLabel"
            
        }

    }
    
    public struct JourneyPage {
        
        public static let Title: LocalizedStringKey = "JourneyPage:Title"
        public static let PlanATrip: LocalizedStringKey = "JourneyPage:PlanATrip"
        
        public static let FromPrompt: LocalizedStringKey = "JourneyPage:FromPrompt"
        public static let ToPrompt: LocalizedStringKey = "JourneyPage:ToPrompt"
        public static let ViaPrompt: LocalizedStringKey = "JourneyPage:ViaPrompt"
        
        public static let PlanJourneyButton: LocalizedStringKey = "JourneyPage:PlanButton"
        
        public static let ChooseStart: LocalizedStringKey = "JourneyPage:Search:ChooseStart"
        public static let ChooseEnd: LocalizedStringKey = "JourneyPage:Search:ChooseEnd"
        public static let ChooseVia: LocalizedStringKey = "JourneyPage:Search:ChooseVia"
        
        public static let Searching: LocalizedStringKey = "JourneyPage:Searching"
        public static let SearchNoResultsTitle: LocalizedStringKey = "JourneyPage:Search:NoResultsTitle"
        public static let SearchNoResultsDescription: LocalizedStringKey = "JourneyPage:Search:NoResultsDescription"
        
        public static let SearchBeginTitle: LocalizedStringKey = "JourneyPage:Search:BeginJourneyTitle"
        public static let SearchBeginDescription: LocalizedStringKey = "JourneyPage:Search:BeginJourneyDescription"
        public static let SearchEndTitle: LocalizedStringKey = "JourneyPage:Search:EndJourneyTitle"
        public static let SearchEndDescription: LocalizedStringKey = "JourneyPage:Search:EndJourneyDescription"
        public static let SearchViaTitle: LocalizedStringKey = "JourneyPage:Search:ViaJourneyTitle"
        public static let SearchViaDescription: LocalizedStringKey = "JourneyPage:Search:ViaJourneyDescription"
        
        public static let ReplacementBus: LocalizedStringKey = "JourneyPage:ReplacementBus"
        
        public static let FastestJourney: LocalizedStringKey = "JourneyPage:FastestJourney"
        public static let Journey: LocalizedStringKey = "JourneyPage:Journey"
        public static let Cycle: LocalizedStringKey = "JourneyPage:Cycle"
        public static let WalkIfCan: LocalizedStringKey = "JourneyPage:WalkIfCan"
        
        public static let Now: LocalizedStringKey = "JourneyPage:Now"
        public static let Tomorrow: LocalizedStringKey = "JourneyPage:Tomorrow"
        
        public static let ArriveBy: LocalizedStringKey = "JourneyPage:ArriveBy"
        public static func ArriveBy(_ value: String) -> LocalizedStringKey {
            LocalizedStringKey("JourneyPage:ArriveBy:\(value)")
        }
        
        public static let LeaveAt: LocalizedStringKey = "JourneyPage:LeaveAt"
        public static func LeaveAt(_ value: String) -> LocalizedStringKey {
            LocalizedStringKey("JourneyPage:LeaveAt:\(value)")
        }
        
        public static let MyLocation: LocalizedStringKey = "JourneyPage:MyLocation"
        
        public static func Mins(_ mins: Int) -> LocalizedStringKey {
            LocalizedStringKey("JourneyPage:Mins:\(mins)")
        }
        
        public static let LeaveNow: LocalizedStringKey = "JourneyPage:LeaveNow"
        public static func LeaveWithin(_ mins: Int) ->  LocalizedStringKey {
            LocalizedStringKey("JourneyPage:LeaveWithin:\(mins)")
        }
    }
    
    public struct Misc {
        public static let Searching: LocalizedStringKey = "Misc:Searching..."
        public static let Loading: LocalizedStringKey = "Misc:Loading..."
        public static let And: LocalizedStringKey = "Misc:And"
        public static let OxfordComma: LocalizedStringKey = "Misc:OxfordComma"
        public static let ThenLower: LocalizedStringKey = "Misc:ThenLower"
        public static let Ok: LocalizedStringKey = "Misc:Ok"
        public static let Results: LocalizedStringKey = "Misc:Results"
    }
    
    public struct Errors {
        public static let NoLineModesAPI: LocalizedStringKey = "Errors:NoLineModesFromAPI"
        public static let NoLineModesAPIDescription: LocalizedStringKey = "Errors:NoLineModesFromAPI:Description"
        public static let StopFailedLoad: LocalizedStringKey = "Errors:StopFailedLoading"
    }
    
    public struct Assets {
        public static let BusLoading = "BusLoading"
    }
    
    public struct Accessibility {
        
        public static let MapLabelUserSearch: LocalizedStringKey = "Accessibility:Map:UserSearchLabel"
        public static let MapHintUserSearch: LocalizedStringKey = "Accessibility:Map:UserSearchHint"
        public static let MapLabelMapSearch: LocalizedStringKey = "Accessibility:Map:MapSearchLabel"
        public static let MapHintMapSearch: LocalizedStringKey = "Accessibility:Map:MapSearchHint"
        public static let MapLabelFilterSheet: LocalizedStringKey = "Accessibility:Map:FilterSheetLabel"
        public static let MapHintFilterSheet: LocalizedStringKey = "Accessibility:Map:FilterSheetHint"
        
        public static let MapShowsStopLabel: LocalizedStringKey = "Accessibility:StopPage:MapShowsStopLabel"
        public static let OpensJourneyForStopLabel: LocalizedStringKey = "Accessibility:StopPage:OpensJourneyForStopLabel"
        public static let StopArrivalsLabel: LocalizedStringKey = "Accessibility:StopPage:UpcomingArrivalsLabel"
        public static let StopArrivalsHint: LocalizedStringKey = "Accessibility:StopPage:UpcomingArrivalsHint"
        public static let StopArrivalsUpdatedMessage: LocalizedStringKey = "Accessibility:StopPage:ArrivalsUpdatedMessage"
        public static let StopNextArrivalIs: LocalizedStringKey = "Accessibility:StopPage:NextArrivalIs"
        public static let StopManualRefreshLabel: LocalizedStringKey = "Accessibility:StopPage:RefreshArrivalsLabel"
        
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
        
        public static func FilterSheetAreaLabel(_ area: String) -> LocalizedStringKey {
            LocalizedStringKey("Accessibility:Map:FilterLineModesForArea:\(area)")
        }
        
        public static func LineArrivalsLabel(_ lineName: String) -> LocalizedStringKey {
            LocalizedStringKey("Accessibility:StopPage:LineArrivals:\(lineName)")
        }
        
        public static func ToiletInfoRowLabel(_ info: StopPointToiletInfo) -> LocalizedStringKey {
            let type = info.type
            let accessibleString = info.accessible ? "are disability-friendly" : "are not disability-friendly"
            let babyString = info.hasBabyGate ? "does" : "does not"
            let freeString = info.free ? "are free to enter" : "are not free to enter"
            return LocalizedStringKey("Accessibility:StopPage:ToiletLabel:\(type):\(freeString):\(accessibleString):\(babyString)")
        }
    }
}

public struct Icons {
    public static let gear: String = "gear"
    public static let arrow_right: String = "arrow.right"
    public static let arrow_up: String = "arrow.up"
    public static let arrow_down: String = "arrow.down"
    public static let arrowUpAndDown: String = "arrow.up.arrow.down"
    public static let arrow_clockwise: String = "arrow.clockwise"
    public static let location_slash = "location.slash"
    public static let locationFill = "location.fill"
    public static let cross_circle_fill = "xmark.circle.fill"
    public static let cross = "xmark"
    public static let check = "checkmark"
    public static let accessible = "figure.roll"
    public static let family = "figure.and.child.holdinghands"
    public static let map = "map"
    public static let map_circle = "map.circle.fill"
    public static let mapPinSlashed = "mappin.slash"
    public static let bike = "bicycle"
    public static let bike_circle = "bicycle.circle"
    public static let bike_circle_fill = "bicycle.circle.fill"
    public static let train = "tram"
    public static let bus = "bus"
    public static let location = "location"
    public static let location_magnifyingglass = "location.magnifyingglass"
    public static let filter = "line.3.horizontal.decrease.circle"
    public static let info = "info"
    public static let info_circle = "info.circle"
    public static let add = "plus"
    public static let minus = "minus"
    public static let clockFilled = "clock.fill"
    public static let walk = "figure.walk"
}
