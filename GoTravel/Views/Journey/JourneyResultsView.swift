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
                JourneyOptionCard(journey: journey, isModeFastest: isFastestMode, isFastestOverall: index == 0, index: index)
                    .padding(.vertical, 4)
                    .onTapGesture {
                        GlobalViewModel.shared.addToCurrentNavStack(JourneyDetailNavModel(journey: journey))
                    }
            }
        }
    }
    
    private func getFastestModeJourneyIndex(_ ordered: [Journey]) -> Int? {
        
        let fastest = ordered.firstIndex { !Set($0.journeyLegs.compactMap { $0.legDetails.lineMode.lineModeId }).isSubset(of: ["walking", "cycle"]) }
        
        return fastest
    }
    
    
}

public struct JourneyOptionCard: View {
    
    let journey: Journey
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
                hintForMode(leg)
            }
        }
        .accessibilityElement()
        .accessibilityLabel(modesAccessibilityLabel())
        .accessibilityHint(Strings.Misc.TapToSeeMore)
    }
    
    @ViewBuilder
    private func hintForMode(_ leg: JourneyLeg) -> some View {
        let mode = leg.legDetails.lineMode
        if mode.lineModeId == "walking" {
            HStack(spacing: 1) {
                Image(systemName: Icons.walk)
                Text(String(describing: leg.legDuration))
            }
        }
        else if mode.lineModeId == "cycle" {
            HStack(spacing: 1) {
                Image(systemName: Icons.bike)
                Text(String(describing: leg.legDuration))
            }
        }
        else if mode.lineModeId.contains("replacement-bus") {
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
            if (mode.hasFlag("LLV_DisplaysLines")), let line = mode.lines.first {
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
    
    private func headerString() -> LocalizedStringKey {
        if isModeFastest {
            return Strings.JourneyPage.FastestJourney
        }
        
        let modes = Set(journey.journeyLegs.compactMap { $0.legDetails.lineMode.lineModeId })
        
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
        
        var modeNames: [String] = []
        for mode in journey.journeyLegs.compactMap({ $0.legDetails.lineMode }) {
            if mode.lineModeId == "walking" {
                modeNames.append("walking")
            } else if mode.lineModeId == "cycle" {
                modeNames.append("cycle")
            } else if mode.lineModeId.contains("replacement-bus") {
                modeNames.append("a replacement bus service")
            } else {
                modeNames.append(mode.lineModeName)
            }
        }
        let modeMessage = modeNames.joined(separator: ", then ")
        return Strings.JourneyPage.Accessibility.JourneyModesLabel(modeMessage)
    }
}

#if DEBUG
#Preview {
    
    @State var vm = JourneyPlannerViewModel()
    vm.from = .init(displayName: "Stratford", coordinate: .init(latitude: 51.54090678453668, longitude: -0.0016245982725225947))
    vm.to = .init(displayName: "Gidea Park", coordinate: .init(latitude: 51.584014356819374, longitude: 0.1991439153059676))
    
    
    return ScrollView {
        JourneyResultsView(result: PreviewDataJourney.PreviewJourneyResponse())
            .padding(.horizontal, 16)
    }
}
#endif
