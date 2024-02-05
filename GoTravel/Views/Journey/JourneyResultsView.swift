//
//  JourneyResultsView.swift
//  GoTravel
//
//  Created by Tom Knighton on 02/02/2024.
//

import SwiftUI
import GoTravel_Models
import WrappingHStack

public struct JourneyResultsView: View {
    
    let result: JourneyOptionsResult
    
    public var body: some View {
        VStack {
            let ordered = result.journeyOptions.sorted(by: { $0.endJourneyAt < $1.endJourneyAt })
            let fastest = getFastestModeJourneyIndex(ordered)
            
            Text(Strings.Misc.Results)
                .font(.title3.bold())
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(Array(ordered.enumerated()), id: \.element.id) { index, journey in
                let isFastestMode = index == fastest
                JourneyOptionCard(journey: journey, lineModes: result.lineModes, isModeFastest: isFastestMode, isFastestOverall: index == 0, index: index)
                    .padding(.vertical, 4)                    
            }
        }
    }
    
    private func getFastestModeJourneyIndex(_ ordered: [Journey]) -> Int? {
        
        let fastest = ordered.firstIndex { !Set($0.journeyLegs.compactMap { $0.legDetails.modeId }).isSubset(of: ["walking", "cycle"]) }
        
        return fastest
    }
    
    
}

public struct JourneyOptionCard: View {
    
    let journey: Journey
    let lineModes: [LineMode]
    var isModeFastest: Bool = false
    var isFastestOverall: Bool = false
    var index: Int
    
    public var body: some View {
        VStack {
            Text(headerString())
                .bold()
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityLabel(Strings.JourneyPage.Accessibility.JourneyOptionLabel(index + 1))
                .accessibilityHint(Strings.Misc.TapToSeeMore)
            Text(leaveAtString())
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            
            HStack {
                modeListView()
                Spacer()
                Text(Strings.JourneyPage.Mins(journey.totalDuration))
                    .bold()
                    .fontDesign(.rounded)
                    .accessibilityHint(Strings.Misc.TapToSeeMore)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(isModeFastest ? Color.green : Color.layer2)
        .foregroundStyle(isModeFastest ? Color.white : Color.primary)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
    }
    
    @ViewBuilder
    private func modeListView() -> some View {
        let legs = journey.journeyLegs
        WrappingHStack(alignment: .leading) {
            ForEach(legs, id: \.beginLegAt) { leg in
                hintForMode(leg.legDetails.modeId, leg: leg)
            }
        }
        .accessibilityElement()
        .accessibilityLabel(modesAccessibilityLabel())
        .accessibilityHint(Strings.Misc.TapToSeeMore)
    }
    
    @ViewBuilder
    private func hintForMode(_ modeId: String, leg: JourneyLeg) -> some View {
        if modeId == "walking" {
            HStack(spacing: 1) {
                Image(systemName: Icons.walk)
                Text(String(describing: leg.legDuration))
            }
        }
        else if modeId == "cycle" {
            HStack(spacing: 1) {
                Image(systemName: Icons.bike)
                Text(String(describing: leg.legDuration))
            }
        }
        else if modeId.contains("replacement-bus") {
            Text(Strings.JourneyPage.ReplacementBus)
                .bold()
                .fontDesign(.rounded)
                .foregroundStyle(.white)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .font(.footnote)
                .background(.red)
                .clipShape(.rect(cornerRadius: 5))
        }
        else {
            if let mode = lineModes.first(where: { $0.lineModeId == modeId }) {
                if (mode.hasFlag("LLV_DisplaysLines")),
                    let lineId = leg.legDetails.lineIds.first,
                   let line = mode.lines.first(where: { $0.lineId == lineId }){
                    Text(line.lineName)
                        .bold()
                        .fontDesign(.rounded)
                        .foregroundStyle(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .font(.footnote)
                        .background(Color(hex: line.linePrimaryColour) ?? Color(hex: mode.branding.lineModeBackgroundColour) ?? .red)
                        .clipShape(.rect(cornerRadius: 5))
                    
                } else {
                    AsyncImage(url: URL(string: mode.branding.lineModeLogoUrl)) { img in
                        img
                            .resizable()
                            .frame(width: 20, height: 20)
                            .shadow(radius: 3)
                            .accessibilityElement()
                            .accessibilityLabel(mode.lineModeName)
                    } placeholder: {
                        EmptyView()
                     }
                }
            }
        }
    }
    
    private func headerString() -> LocalizedStringKey {
        if isModeFastest {
            return Strings.JourneyPage.FastestJourney
        }
        
        let modes = Set(journey.journeyLegs.compactMap { $0.legDetails.modeId })
        
        if modes.count == 2 && modes.contains("walking") && modes.contains("cycle") {
            return Strings.JourneyPage.Journey
        }
        if modes.count == 1 && modes.contains("cycle") {
            return Strings.JourneyPage.Cycle
        }
        if modes.count == 1 && modes.contains("walking") {
            return Strings.JourneyPage.WalkIfCan
        }
    
        
        return Strings.JourneyPage.Journey
    }
    
    private func leaveAtString() -> LocalizedStringKey {
        let minsUntilLeave = Date().timeUntil(journey.beginJourneyAt, unit: .minutes)
        if minsUntilLeave <= 1 {
            return Strings.JourneyPage.LeaveNow
        }
        if minsUntilLeave <= 5 {
            return Strings.JourneyPage.LeaveWithin(Int(minsUntilLeave))
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return Strings.JourneyPage.LeaveAt(dateFormatter.string(from: journey.beginJourneyAt))
    }
    
    private func modesAccessibilityLabel() -> LocalizedStringKey {
        
        
        let modeIds = journey.journeyLegs.compactMap { $0.legDetails.modeId }
        var modeNames: [String] = []
        for id in modeIds {
            if id == "walking" {
                modeNames.append("walking")
            } else if id == "cycle" {
                modeNames.append("cycle")
            } else if id.contains("replacement-bus") {
                modeNames.append("a replacement bus service")
            } else if let mode = self.lineModes.first(where: { $0.lineModeId == id }) {
                modeNames.append(mode.lineModeName)
            }
        }
        let modeMessage = modeNames.joined(separator: ", then ")
        return Strings.JourneyPage.Accessibility.JourneyModesLabel(modeMessage)
    }
}


#Preview {
    
    @State var vm = JourneyPlannerViewModel()
    vm.from = .init(displayName: "Stratford", coordinate: .init(latitude: 51.54090678453668, longitude: -0.0016245982725225947))
    vm.to = .init(displayName: "Gidea Park", coordinate: .init(latitude: 51.584014356819374, longitude: 0.1991439153059676))
    
    var resultString = """
    {
        "journeyOptions": [
            {
                "beginJourneyAt": "2024-02-03T12:45:00",
                "endJourneyAt": "2024-02-03T13:34:00",
                "totalDuration": 49,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-03T13:45:00",
                        "endLegAt": "2024-02-03T14:01:00",
                        "legDuration": 16,
                        "startAtStopId": null,
                        "startAtStopName": "1 Bow Interchange",
                        "endAtStopId": "940GZZLUBWR",
                        "endAtStopName": "Bow Road Underground Station",
                        "legDetails": {
                            "summary": "Walk to Bow Road Station",
                            "detailedSummary": "Walk to Bow Road Station",
                            "modeId": "walking",
                            "lineIds": [],
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 659 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 659
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T13:01:00",
                        "endLegAt": "2024-02-03T13:25:00",
                        "legDuration": 24,
                        "startAtStopId": "940GZZLUBWR",
                        "startAtStopName": "Bow Road Underground Station",
                        "endAtStopId": "940GZZLUVIC",
                        "endAtStopName": "Victoria Underground Station",
                        "legDetails": {
                            "summary": "District line to Victoria",
                            "detailedSummary": "District line towards Ealing Broadway",
                            "modeId": "tfl-tube",
                            "lineIds": [
                                "tfl-district"
                            ],
                            "legSteps": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T13:25:00",
                        "endLegAt": "2024-02-03T13:34:00",
                        "legDuration": 9,
                        "startAtStopId": "940GZZLUVIC",
                        "startAtStopName": "Victoria Underground Station",
                        "endAtStopId": null,
                        "endAtStopName": "10 Eccleston Street, Belgravia",
                        "legDetails": {
                            "summary": "Walk to 10 Eccleston Street, Belgravia",
                            "detailedSummary": "Walk to 10 Eccleston Street, Belgravia",
                            "modeId": "walking",
                            "lineIds": [],
                            "legSteps": [
                                {
                                    "summary": "Continue along  Eccleston Bridge for 17 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.49407309241,
                                    "longitude": -0.14653723274,
                                    "distanceOfStep": 17
                                },
                                {
                                    "summary": "Continue along  on to Eccleston Street, continue for 83 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.494130653439996,
                                    "longitude": -0.14676539382,
                                    "distanceOfStep": 83
                                }
                            ]
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-03T12:51:00",
                "endJourneyAt": "2024-02-03T13:37:00",
                "totalDuration": 46,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-03T12:51:00",
                        "endLegAt": "2024-02-03T12:59:00",
                        "legDuration": 8,
                        "startAtStopId": null,
                        "startAtStopName": "1 Bow Interchange",
                        "endAtStopId": "490G000421",
                        "endAtStopName": "Bow Church",
                        "legDetails": {
                            "summary": "Walk to Bow Church",
                            "detailedSummary": "Walk to Bow Church",
                            "modeId": "walking",
                            "lineIds": [],
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 167 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 167
                                },
                                {
                                    "summary": "Turn left for 15 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.52843138626,
                                    "longitude": -0.01824426719,
                                    "distanceOfStep": 15
                                },
                                {
                                    "summary": "Turn left on to Bow Road, continue for 62 metres",
                                    "direction": "East",
                                    "latitude": 51.528321363130004,
                                    "longitude": -0.018119291710000002,
                                    "distanceOfStep": 62
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T12:59:00",
                        "endLegAt": "2024-02-03T13:02:00",
                        "legDuration": 3,
                        "startAtStopId": "490G000421",
                        "startAtStopName": "Bow Church",
                        "endAtStopId": "940GZZLUBWR",
                        "endAtStopName": "Bow Road Underground Station",
                        "legDetails": {
                            "summary": "425 bus to Bow Road Station",
                            "detailedSummary": "425 bus towards Clapton, Nightingale Road",
                            "modeId": "tfl-bus",
                            "lineIds": [
                                "tfl-425"
                            ],
                            "legSteps": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T13:05:00",
                        "endLegAt": "2024-02-03T13:28:00",
                        "legDuration": 23,
                        "startAtStopId": "940GZZLUBWR",
                        "startAtStopName": "Bow Road Underground Station",
                        "endAtStopId": "940GZZLUVIC",
                        "endAtStopName": "Victoria Underground Station",
                        "legDetails": {
                            "summary": "District line to Victoria",
                            "detailedSummary": "District line towards Wimbledon",
                            "modeId": "tfl-tube",
                            "lineIds": [
                                "tfl-district"
                            ],
                            "legSteps": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T13:28:00",
                        "endLegAt": "2024-02-03T13:37:00",
                        "legDuration": 9,
                        "startAtStopId": "940GZZLUVIC",
                        "startAtStopName": "Victoria Underground Station",
                        "endAtStopId": null,
                        "endAtStopName": "10 Eccleston Street, Belgravia",
                        "legDetails": {
                            "summary": "Walk to 10 Eccleston Street, Belgravia",
                            "detailedSummary": "Walk to 10 Eccleston Street, Belgravia",
                            "modeId": "walking",
                            "lineIds": [],
                            "legSteps": [
                                {
                                    "summary": "Continue along  Eccleston Bridge for 17 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.49407309241,
                                    "longitude": -0.14653723274,
                                    "distanceOfStep": 17
                                },
                                {
                                    "summary": "Continue along  on to Eccleston Street, continue for 83 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.494130653439996,
                                    "longitude": -0.14676539382,
                                    "distanceOfStep": 83
                                }
                            ]
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-03T13:54:00",
                "endJourneyAt": "2024-02-03T14:43:00",
                "totalDuration": 49,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-03T12:54:00",
                        "endLegAt": "2024-02-03T13:10:00",
                        "legDuration": 16,
                        "startAtStopId": null,
                        "startAtStopName": "1 Bow Interchange",
                        "endAtStopId": "940GZZLUBWR",
                        "endAtStopName": "Bow Road Underground Station",
                        "legDetails": {
                            "summary": "Walk to Bow Road Station",
                            "detailedSummary": "Walk to Bow Road Station",
                            "modeId": "walking",
                            "lineIds": [],
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 659 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 659
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T13:10:00",
                        "endLegAt": "2024-02-03T13:34:00",
                        "legDuration": 24,
                        "startAtStopId": "940GZZLUBWR",
                        "startAtStopName": "Bow Road Underground Station",
                        "endAtStopId": "940GZZLUVIC",
                        "endAtStopName": "Victoria Underground Station",
                        "legDetails": {
                            "summary": "District line to Victoria",
                            "detailedSummary": "District line towards Ealing Broadway",
                            "modeId": "tfl-tube",
                            "lineIds": [
                                "tfl-district"
                            ],
                            "legSteps": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T13:34:00",
                        "endLegAt": "2024-02-03T13:43:00",
                        "legDuration": 9,
                        "startAtStopId": "940GZZLUVIC",
                        "startAtStopName": "Victoria Underground Station",
                        "endAtStopId": null,
                        "endAtStopName": "10 Eccleston Street, Belgravia",
                        "legDetails": {
                            "summary": "Walk to 10 Eccleston Street, Belgravia",
                            "detailedSummary": "Walk to 10 Eccleston Street, Belgravia",
                            "modeId": "walking",
                            "lineIds": [],
                            "legSteps": [
                                {
                                    "summary": "Continue along  Eccleston Bridge for 17 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.49407309241,
                                    "longitude": -0.14653723274,
                                    "distanceOfStep": 17
                                },
                                {
                                    "summary": "Continue along  on to Eccleston Street, continue for 83 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.494130653439996,
                                    "longitude": -0.14676539382,
                                    "distanceOfStep": 83
                                }
                            ]
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-03T13:43:00",
                "endJourneyAt": "2024-02-03T15:07:00",
                "totalDuration": 84,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-03T12:43:00",
                        "endLegAt": "2024-02-03T12:51:00",
                        "legDuration": 8,
                        "startAtStopId": null,
                        "startAtStopName": "1 Bow Interchange",
                        "endAtStopId": "490G000421",
                        "endAtStopName": "Bow Church",
                        "legDetails": {
                            "summary": "Walk to Bow Church",
                            "detailedSummary": "Walk to Bow Church",
                            "modeId": "walking",
                            "lineIds": [],
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 167 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 167
                                },
                                {
                                    "summary": "Turn left for 15 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.52843138626,
                                    "longitude": -0.01824426719,
                                    "distanceOfStep": 15
                                },
                                {
                                    "summary": "Turn left on to Bow Road, continue for 62 metres",
                                    "direction": "East",
                                    "latitude": 51.528321363130004,
                                    "longitude": -0.018119291710000002,
                                    "distanceOfStep": 62
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T12:51:00",
                        "endLegAt": "2024-02-03T13:18:00",
                        "legDuration": 27,
                        "startAtStopId": "490G000421",
                        "startAtStopName": "Bow Church",
                        "endAtStopId": null,
                        "endAtStopName": "Liverpool Street Station",
                        "legDetails": {
                            "summary": "205 bus to Liverpool Street Station",
                            "detailedSummary": "205 bus towards Paddington",
                            "modeId": "tfl-bus",
                            "lineIds": [
                                "tfl-205"
                            ],
                            "legSteps": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T13:27:00",
                        "endLegAt": "2024-02-03T13:45:00",
                        "legDuration": 18,
                        "startAtStopId": null,
                        "startAtStopName": "Liverpool Street Station",
                        "endAtStopId": "490G00019703",
                        "endAtStopName": "Aldwych / Drury Lane",
                        "legDetails": {
                            "summary": "26 bus to Aldwych / Drury Lane",
                            "detailedSummary": "26 bus towards Victoria",
                            "modeId": "tfl-bus",
                            "lineIds": [
                                "tfl-26"
                            ],
                            "legSteps": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T13:51:00",
                        "endLegAt": "2024-02-03T14:00:00",
                        "legDuration": 9,
                        "startAtStopId": null,
                        "startAtStopName": "Aldwych / Drury Lane",
                        "endAtStopId": "490G00248G",
                        "endAtStopName": "Victoria Station",
                        "legDetails": {
                            "summary": "24 bus to Victoria Station",
                            "detailedSummary": "24 bus towards Pimlico",
                            "modeId": "tfl-bus",
                            "lineIds": [
                                "tfl-24"
                            ],
                            "legSteps": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-03T14:00:00",
                        "endLegAt": "2024-02-03T14:07:00",
                        "legDuration": 7,
                        "startAtStopId": "490G00248G",
                        "startAtStopName": "Victoria Station",
                        "endAtStopId": null,
                        "endAtStopName": "10 Eccleston Street, Belgravia",
                        "legDetails": {
                            "summary": "Walk to 10 Eccleston Street, Belgravia",
                            "detailedSummary": "Walk to 10 Eccleston Street, Belgravia",
                            "modeId": "walking",
                            "lineIds": [],
                            "legSteps": [
                                {
                                    "summary": "Continue along  Victoria Arcade for 13 metres",
                                    "direction": "South",
                                    "latitude": 51.496303247369994,
                                    "longitude": -0.14369509199,
                                    "distanceOfStep": 13
                                },
                                {
                                    "summary": "Turn right on to Terminus Place, continue for 110 metres",
                                    "direction": "West",
                                    "latitude": 51.496186647550005,
                                    "longitude": -0.14371423575,
                                    "distanceOfStep": 110
                                },
                                {
                                    "summary": "Turn left on to Buckingham Palace Road, continue for 103 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.49617393654,
                                    "longitude": -0.14518422944,
                                    "distanceOfStep": 103
                                },
                                {
                                    "summary": "Turn right on to Phipps Mews, continue for 44 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.495338743649995,
                                    "longitude": -0.14582320058999998,
                                    "distanceOfStep": 44
                                },
                                {
                                    "summary": "Continue along  for 18 metres",
                                    "direction": "West",
                                    "latitude": 51.49550960926,
                                    "longitude": -0.14639252404,
                                    "distanceOfStep": 18
                                },
                                {
                                    "summary": "Turn left on to Eccleston Place, continue for 142 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.49552269186999,
                                    "longitude": -0.14665130906999999,
                                    "distanceOfStep": 142
                                },
                                {
                                    "summary": "Turn right on to Eccleston Street, continue for 25 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.4943673784,
                                    "longitude": -0.14751931438,
                                    "distanceOfStep": 25
                                }
                            ]
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-03T12:42:00",
                "endJourneyAt": "2024-02-03T13:28:00",
                "totalDuration": 46,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-03T12:42:00",
                        "endLegAt": "2024-02-03T13:28:00",
                        "legDuration": 46,
                        "startAtStopId": null,
                        "startAtStopName": "1 Bow Interchange",
                        "endAtStopId": null,
                        "endAtStopName": "10 Eccleston Street",
                        "legDetails": {
                            "summary": "Cycle to 10 Eccleston Street",
                            "detailedSummary": "Cycle to 10 Eccleston Street",
                            "modeId": "cycle",
                            "lineIds": [],
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn left on to Bow Interchange, continue for 290 metres",
                                    "direction": "NorthEast",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 290
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 843 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52876791257,
                                    "longitude": -0.01634100333,
                                    "distanceOfStep": 843
                                },
                                {
                                    "summary": "Continue along  on to Mile End Road, continue for 2133 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52658069969,
                                    "longitude": -0.027954833119999998,
                                    "distanceOfStep": 2133
                                },
                                {
                                    "summary": "Continue along  on to Whitechapel Road, continue for 1020 metres",
                                    "direction": "West",
                                    "latitude": 51.51981618097,
                                    "longitude": -0.05638377594,
                                    "distanceOfStep": 1020
                                },
                                {
                                    "summary": "Continue along  on to Whitechapel High Street, continue for 348 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.516078672629995,
                                    "longitude": -0.06965878551,
                                    "distanceOfStep": 348
                                },
                                {
                                    "summary": "Continue along  on to Aldgate High Street, continue for 297 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.514475880170004,
                                    "longitude": -0.07390618743,
                                    "distanceOfStep": 297
                                },
                                {
                                    "summary": "Continue along  on to Leadenhall Street, continue for 447 metres",
                                    "direction": "West",
                                    "latitude": 51.5132612504,
                                    "longitude": -0.07770458513,
                                    "distanceOfStep": 447
                                },
                                {
                                    "summary": "Continue along  on to Cornhill, continue for 337 metres",
                                    "direction": "West",
                                    "latitude": 51.51339307757,
                                    "longitude": -0.08411246157,
                                    "distanceOfStep": 337
                                },
                                {
                                    "summary": "Continue along  on to Mansion House Street, continue for 35 metres",
                                    "direction": "West",
                                    "latitude": 51.51337341077,
                                    "longitude": -0.08897019033,
                                    "distanceOfStep": 35
                                },
                                {
                                    "summary": "Continue along  on to Poultry, continue for 122 metres",
                                    "direction": "West",
                                    "latitude": 51.513390609540004,
                                    "longitude": -0.08947389672999999,
                                    "distanceOfStep": 122
                                },
                                {
                                    "summary": "Continue along  on to Cheapside, continue for 232 metres",
                                    "direction": "West",
                                    "latitude": 51.513634424450004,
                                    "longitude": -0.09119316552,
                                    "distanceOfStep": 232
                                },
                                {
                                    "summary": "Turn left on to Bread Street, continue for 178 metres",
                                    "direction": "South",
                                    "latitude": 51.5141818426,
                                    "longitude": -0.09444190062,
                                    "distanceOfStep": 178
                                },
                                {
                                    "summary": "Turn right on to Cannon Street, continue for 144 metres",
                                    "direction": "West",
                                    "latitude": 51.512646697899996,
                                    "longitude": -0.09515450092000001,
                                    "distanceOfStep": 144
                                },
                                {
                                    "summary": "Continue along  on to St Paul's Churchyard, continue for 231 metres",
                                    "direction": "West",
                                    "latitude": 51.51302068024,
                                    "longitude": -0.09714217462000001,
                                    "distanceOfStep": 231
                                },
                                {
                                    "summary": "Continue along  on to Ludgate Hill, continue for 272 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.51363772641,
                                    "longitude": -0.10025832830999999,
                                    "distanceOfStep": 272
                                },
                                {
                                    "summary": "Continue along  on to Ludgate Circus, continue for 40 metres",
                                    "direction": "West",
                                    "latitude": 51.514149276,
                                    "longitude": -0.1040851539,
                                    "distanceOfStep": 40
                                },
                                {
                                    "summary": "Continue along  on to New Bridge Street, continue for 170 metres",
                                    "direction": "South",
                                    "latitude": 51.51401038046,
                                    "longitude": -0.10439358028,
                                    "distanceOfStep": 170
                                },
                                {
                                    "summary": "Turn right on to Tudor Street, continue for 260 metres",
                                    "direction": "West",
                                    "latitude": 51.51247894776,
                                    "longitude": -0.10422656455,
                                    "distanceOfStep": 260
                                },
                                {
                                    "summary": "Turn left on to Temple Avenue, continue for 31 metres",
                                    "direction": "South",
                                    "latitude": 51.51253941419,
                                    "longitude": -0.10797114215,
                                    "distanceOfStep": 31
                                },
                                {
                                    "summary": "Continue along  on to Temple Chambers, continue for 38 metres",
                                    "direction": "South",
                                    "latitude": 51.51226059916,
                                    "longitude": -0.10796828268999999,
                                    "distanceOfStep": 38
                                },
                                {
                                    "summary": "Continue along  on to Temple Avenue, continue for 100 metres",
                                    "direction": "South",
                                    "latitude": 51.511919343,
                                    "longitude": -0.10799683373,
                                    "distanceOfStep": 100
                                },
                                {
                                    "summary": "Turn right on to Victoria Embankment, continue for 595 metres",
                                    "direction": "West",
                                    "latitude": 51.51102092128,
                                    "longitude": -0.10804846804000001,
                                    "distanceOfStep": 595
                                },
                                {
                                    "summary": "Continue along  for 56 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.510338052419996,
                                    "longitude": -0.1164640597,
                                    "distanceOfStep": 56
                                },
                                {
                                    "summary": "Continue along  on to Victoria Embankment, continue for 1189 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.51015214062,
                                    "longitude": -0.11720669376,
                                    "distanceOfStep": 1189
                                },
                                {
                                    "summary": "Turn right on to Bridge Street, continue for 143 metres",
                                    "direction": "West",
                                    "latitude": 51.500918657750006,
                                    "longitude": -0.1240565437,
                                    "distanceOfStep": 143
                                },
                                {
                                    "summary": "Continue along  on to Great George Street, continue for 240 metres",
                                    "direction": "West",
                                    "latitude": 51.50102346892,
                                    "longitude": -0.12611261312,
                                    "distanceOfStep": 240
                                },
                                {
                                    "summary": "Turn left on to Storeys Gate, continue for 183 metres",
                                    "direction": "South",
                                    "latitude": 51.50127611184,
                                    "longitude": -0.12954582881,
                                    "distanceOfStep": 183
                                },
                                {
                                    "summary": "Turn right on to Tothill Street, continue for 236 metres",
                                    "direction": "West",
                                    "latitude": 51.49963984925,
                                    "longitude": -0.12956959841000001,
                                    "distanceOfStep": 236
                                },
                                {
                                    "summary": "Continue along  on to Broadway, continue for 63 metres",
                                    "direction": "West",
                                    "latitude": 51.49969399537,
                                    "longitude": -0.13296761644000002,
                                    "distanceOfStep": 63
                                },
                                {
                                    "summary": "Continue along  on to Petty France, continue for 308 metres",
                                    "direction": "West",
                                    "latitude": 51.49972640637,
                                    "longitude": -0.13387398209999998,
                                    "distanceOfStep": 308
                                },
                                {
                                    "summary": "Take a slight right on to Buckingham Gate, continue for 436 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.49905700731,
                                    "longitude": -0.13815155653,
                                    "distanceOfStep": 436
                                },
                                {
                                    "summary": "Continue along  on to Buckingham Palace Road, continue for 610 metres",
                                    "direction": "South",
                                    "latitude": 51.49914589092,
                                    "longitude": -0.14319058888,
                                    "distanceOfStep": 610
                                },
                                {
                                    "summary": "Turn right on to Eccleston Street, continue for 83 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.494130653439996,
                                    "longitude": -0.14676539382,
                                    "distanceOfStep": 83
                                }
                            ]
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-03T12:42:00",
                "endJourneyAt": "2024-02-03T15:24:00",
                "totalDuration": 162,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-03T12:42:00",
                        "endLegAt": "2024-02-03T15:24:00",
                        "legDuration": 162,
                        "startAtStopId": null,
                        "startAtStopName": "1 Bow Interchange",
                        "endAtStopId": null,
                        "endAtStopName": "10 Eccleston Street",
                        "legDetails": {
                            "summary": "Cycle to 10 Eccleston Street",
                            "detailedSummary": "Cycle to 10 Eccleston Street",
                            "modeId": "cycle",
                            "lineIds": [],
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 871 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 871
                                },
                                {
                                    "summary": "Continue along  on to Mile End Road, continue for 2130 metres",
                                    "direction": "West",
                                    "latitude": 51.52658069969,
                                    "longitude": -0.027954833119999998,
                                    "distanceOfStep": 2130
                                },
                                {
                                    "summary": "Continue along  on to Whitechapel Road, continue for 1020 metres",
                                    "direction": "West",
                                    "latitude": 51.51981618097,
                                    "longitude": -0.05638377594,
                                    "distanceOfStep": 1020
                                },
                                {
                                    "summary": "Continue along  on to Whitechapel High Street, continue for 348 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.516078672629995,
                                    "longitude": -0.06965878551,
                                    "distanceOfStep": 348
                                },
                                {
                                    "summary": "Continue along  on to Aldgate High Street, continue for 297 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.514475880170004,
                                    "longitude": -0.07390618743,
                                    "distanceOfStep": 297
                                },
                                {
                                    "summary": "Continue along  on to Leadenhall Street, continue for 447 metres",
                                    "direction": "West",
                                    "latitude": 51.5132612504,
                                    "longitude": -0.07770458513,
                                    "distanceOfStep": 447
                                },
                                {
                                    "summary": "Continue along  on to Cornhill, continue for 337 metres",
                                    "direction": "West",
                                    "latitude": 51.51339307757,
                                    "longitude": -0.08411246157,
                                    "distanceOfStep": 337
                                },
                                {
                                    "summary": "Continue along  on to Mansion House Street, continue for 35 metres",
                                    "direction": "West",
                                    "latitude": 51.51337341077,
                                    "longitude": -0.08897019033,
                                    "distanceOfStep": 35
                                },
                                {
                                    "summary": "Take a slight left on to Queen Victoria Street, continue for 1053 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.513390609540004,
                                    "longitude": -0.08947389672999999,
                                    "distanceOfStep": 1053
                                },
                                {
                                    "summary": "Take a slight left for 48 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.51191093466,
                                    "longitude": -0.10413485234,
                                    "distanceOfStep": 48
                                },
                                {
                                    "summary": "Continue along  on to Victoria Embankment, continue for 853 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.51155752606,
                                    "longitude": -0.10452422553,
                                    "distanceOfStep": 853
                                },
                                {
                                    "summary": "Continue along  for 56 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.510338052419996,
                                    "longitude": -0.1164640597,
                                    "distanceOfStep": 56
                                },
                                {
                                    "summary": "Continue along  on to Victoria Embankment, continue for 107 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.51015214062,
                                    "longitude": -0.11720669376,
                                    "distanceOfStep": 107
                                },
                                {
                                    "summary": "Take a slight right on to Savoy Place, continue for 9 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.50970633077,
                                    "longitude": -0.11856529268,
                                    "distanceOfStep": 9
                                },
                                {
                                    "summary": "Take a slight left for 351 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.50975288089,
                                    "longitude": -0.11866425173,
                                    "distanceOfStep": 351
                                },
                                {
                                    "summary": "Take a slight left on to Watergate Walk, continue for 47 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.50812086765,
                                    "longitude": -0.12288169095,
                                    "distanceOfStep": 47
                                },
                                {
                                    "summary": "Turn right on to Villiers Street, continue for 67 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.50775771683,
                                    "longitude": -0.12322805425,
                                    "distanceOfStep": 67
                                },
                                {
                                    "summary": "Turn left on to The Arches, continue for 74 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.50815589225,
                                    "longitude": -0.12394662548,
                                    "distanceOfStep": 74
                                },
                                {
                                    "summary": "Continue along  on to Craven Passage, continue for 70 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.50765447913,
                                    "longitude": -0.12464450603999999,
                                    "distanceOfStep": 70
                                },
                                {
                                    "summary": "Take a slight left on to Northumberland Street, continue for 16 metres",
                                    "direction": "South",
                                    "latitude": 51.50717979139,
                                    "longitude": -0.12532686396,
                                    "distanceOfStep": 16
                                },
                                {
                                    "summary": "Turn right on to Northumberland Avenue, continue for 113 metres",
                                    "direction": "West",
                                    "latitude": 51.50704591256,
                                    "longitude": -0.12538999951,
                                    "distanceOfStep": 113
                                },
                                {
                                    "summary": "Continue along  on to Charing Cross, continue for 68 metres",
                                    "direction": "West",
                                    "latitude": 51.507313860809994,
                                    "longitude": -0.12696412255,
                                    "distanceOfStep": 68
                                },
                                {
                                    "summary": "Take a slight left on to The Mall, continue for 1034 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.507228343840005,
                                    "longitude": -0.12780341888,
                                    "distanceOfStep": 1034
                                },
                                {
                                    "summary": "Turn left for 213 metres",
                                    "direction": "South",
                                    "latitude": 51.502029020340004,
                                    "longitude": -0.14013406896,
                                    "distanceOfStep": 213
                                },
                                {
                                    "summary": "Take a slight right on to Buckingham Gate, continue for 201 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.50023387569,
                                    "longitude": -0.14091314061000002,
                                    "distanceOfStep": 201
                                },
                                {
                                    "summary": "Continue along  on to Buckingham Palace Road, continue for 461 metres",
                                    "direction": "South",
                                    "latitude": 51.49914589092,
                                    "longitude": -0.14319058888,
                                    "distanceOfStep": 461
                                },
                                {
                                    "summary": "Turn right on to Phipps Mews, continue for 44 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.495338743649995,
                                    "longitude": -0.14582320058999998,
                                    "distanceOfStep": 44
                                },
                                {
                                    "summary": "Continue along  for 18 metres",
                                    "direction": "West",
                                    "latitude": 51.49550960926,
                                    "longitude": -0.14639252404,
                                    "distanceOfStep": 18
                                },
                                {
                                    "summary": "Turn left on to Eccleston Place, continue for 142 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.49552269186999,
                                    "longitude": -0.14665130906999999,
                                    "distanceOfStep": 142
                                },
                                {
                                    "summary": "Turn right on to Eccleston Street, continue for 25 metres",
                                    "direction": "NorthWest",
                                    "latitude": 51.4943673784,
                                    "longitude": -0.14751931438,
                                    "distanceOfStep": 25
                                }
                            ]
                        }
                    }
                ]
            }
        ],
        "lineModes": [
            {
                "lineModeId": "tfl-bus",
                "lineModeName": "Bus",
                "lines": [
                    {
                        "lineId": "tfl-205",
                        "lineName": "205",
                        "linePrimaryColour": "#E1251B"
                    },
                    {
                        "lineId": "tfl-24",
                        "lineName": "24",
                        "linePrimaryColour": "#E1251B"
                    },
                    {
                        "lineId": "tfl-26",
                        "lineName": "26",
                        "linePrimaryColour": "#E1251B"
                    },
                    {
                        "lineId": "tfl-425",
                        "lineName": "425",
                        "linePrimaryColour": "#E1251B"
                    }
                ],
                "primaryAreaName": "London",
                "branding": {
                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/bus.png",
                    "lineModeBackgroundColour": "#E1251B",
                    "lineModePrimaryColour": "#E1251B",
                    "lineModeSecondaryColour": null
                },
                "flags": [
                    "LLV_DisplaysLines",
                    "LLV_DisplaysLineNames",
                    "Arrivals_IsBusLike"
                ]
            },
            {
                "lineModeId": "tfl-tube",
                "lineModeName": "Tube",
                "lines": [
                    {
                        "lineId": "tfl-district",
                        "lineName": "District",
                        "linePrimaryColour": "#007934"
                    }
                ],
                "primaryAreaName": "London",
                "branding": {
                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/tube.png",
                    "lineModeBackgroundColour": "#000F9F",
                    "lineModePrimaryColour": "#000F9F",
                    "lineModeSecondaryColour": "#E1251B"
                },
                "flags": [
                    "LLV_DisplaysLines"
                ]
            }
        ]
    }
"""
    
    var data = resultString.data(using: .utf8)
    var model = try! data!.decode(to: JourneyOptionsResult.self)
    
    
    return ScrollView {
        JourneyResultsView(result: model)
            .padding(.horizontal, 16)
    }
}


