//
//  JourneyDetailPage.swift
//  GoTravel
//
//  Created by Tom Knighton on 06/02/2024.
//

import SwiftUI
import GoTravel_Models
import WrappingHStack
import MapKit

public struct JourneyDetailPage: View {
    
    let journey: Journey
    let hint: LocalizedStringKey
    
    @State private var showFullMap: Bool = false
    @State private var viewFullIndex: Int? = nil
    
    public init(_ journey: Journey, hint: LocalizedStringKey? = nil) {
        self.journey = journey
        self.hint = hint ?? Strings.JourneyPage.Journey
    }
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            ScrollView {
                VStack {
                    Group {
                        Text(HeaderString())
                            .font(.title2)
                        Text(ArriveAtString())
                            .font(.title3)
                        
                    }
                    .bold()
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    LegsView()
                    
                    Spacer().frame(height: 8)
                    
                    Button(action: { self.showFullMap = true; }) {
                        ZStack {
                            JourneyMapView(journey: journey, miniView: true)
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer().frame(height: 8)
                                    Button(action:{ self.showFullMap = true }) {
                                        Image(systemName: Icons.arrowExpandCircleFill)
                                            .imageScale(.large)
                                    }
                                    Spacer()
                                }
                                Spacer().frame(width: 8)
                            }
                        }
                    }
                    .frame(height: 200)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(radius: 3)
                    
                    Spacer().frame(height: 16)
                }
            }
            .contentMargins(.horizontal, 16, for: .scrollContent)
            
        }
        .navigationTitle(Text(hint))
        .toolbarBackground(.automatic, for: .navigationBar)
        .toolbarBackground(Color.layer1, for: .navigationBar)
        .fullScreenCover(isPresented: $showFullMap) {
            JourneyMapView(journey: journey, startAtLegIndex: self.viewFullIndex ?? 0)
        }
        .fullScreenCover(item: $viewFullIndex) { index in
            JourneyMapView(journey: journey, startAtLegIndex: index)
        }
    }
    
    
    private func HeaderString() -> LocalizedStringKey {
        return Strings.JourneyPage.Mins(Int(journey.totalDuration))
    }
    
    private func ArriveAtString() -> LocalizedStringKey {
        return Strings.JourneyPage.ArriveBy(journey.endJourneyAt.formatted(date: .omitted, time: .shortened))
    }
    
    @ViewBuilder
    private func LegsView() -> some View {
        VStack {
            Spacer().frame(height: 16)
            ForEach(journey.journeyLegs, id: \.beginLegAt) { leg in
                LegView(leg)
            }
            DestinationRow()
            Spacer().frame(height: 16)
        }
    }
    
    @ViewBuilder
    private func LegView(_ leg: JourneyLeg) -> some View {
        HStack {
            VStack {
                
                switch leg.legDetails.lineMode.lineModeId {
                case "walking":
                    Image(systemName: Icons.walk)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .shadow(radius: 3)
                    GeometryReader { geo in
                        VStack(spacing: 4) {
                            let num = Int(geo.size.height / (5 + 4))
                            ForEach(0..<num, id: \.self) { _ in
                                Circle()
                                    .frame(width: 5, height: 5)
                            }
                        }
                    }
                    .frame(width: 5)
                case "cycle":
                    Image(systemName: Icons.bike)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .shadow(radius: 3)
                    GeometryReader { geo in
                        VStack(spacing: 4) {
                            let num = Int(geo.size.height / (5 + 4))
                            ForEach(0..<num, id: \.self) { _ in
                                Circle()
                                    .frame(width: 5, height: 5)
                            }
                        }
                    }
                    .frame(width: 5)
                default:
                    if let url = URL(string: leg.legDetails.lineMode.branding.lineModeLogoUrl) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .frame(width: 30, height: 30)
                                .shadow(radius: 3)
                        } placeholder: {
                            EmptyView()
                                .frame(width: 30, height: 30)
                        }

                    }
                    Rectangle()
                        .stroke(brandingColour(leg), style: .init(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        .frame(width: 2)
                }
            }
            
            let isFirstLeg = journey.journeyLegs.first?.beginLegAt == leg.beginLegAt
            LegInstructionView(leg, isFirst: isFirstLeg)
                .fontDesign(.rounded)
            Spacer()
        }
    }
    
    @ViewBuilder
    private func LegInstructionView(_ leg: JourneyLeg, isFirst: Bool = false) -> some View {
        VStack(alignment: .leading) {
            switch leg.legDetails.lineMode.lineModeId {
            case "walking":
                if let startAtStop = leg.startAtStop {
                    Text(startAtStop.stopPointName)
                        .bold()
                }
                Text(Strings.JourneyPage.Walk)
                    .bold()
                if isFirst {
                    Text(Strings.JourneyPage.LeaveAt(leg.beginLegAt.formatted(date: .omitted, time: .shortened)))
                }
                Text(Strings.JourneyPage.Mins(leg.legDuration))
                
                Button(action: {
                    self.viewFullIndex = journey.journeyLegs.firstIndex(where: { $0.beginLegAt == leg.beginLegAt })
                }) {
                    HStack {
                        Text(Strings.JourneyPage.ViewRoute)
                        Image(systemName: Icons.map)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color.layer2)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(radius: 3)
                }
                
            case "cycle":
                Text(Strings.JourneyPage.Cycle)
                    .bold()
                if isFirst {
                    Text(Strings.JourneyPage.LeaveAt(leg.beginLegAt.formatted(date: .omitted, time: .shortened)))
                }
                Text(Strings.JourneyPage.Mins(leg.legDuration))
                HStack {
                    Text(Strings.JourneyPage.ViewRoute)
                    Image(systemName: Icons.add)
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
            default:
                Text(leg.startAtName ?? "")
                    .bold()
               
                WrappingHStack(alignment: .leading) {
                    ForEach(leg.legDetails.lineMode.lines, id: \.lineId) { line in
                        Text(line.lineName)
                            .font(.subheadline.bold())
                            .padding(.horizontal, 8)
                            .background(brandingColour(leg))
                            .clipShape(.rect(cornerRadius: 4))
                            .foregroundStyle(.white)
                    }
                }
                Text(leg.beginLegAt.formatted(date: .omitted, time: .shortened))
                    .font(.subheadline)
                JourneyLegExpansionView(leg: leg)
                
            }
        }
    }
    
    @ViewBuilder
    private func DestinationRow() -> some View {
        HStack(alignment: .top) {
            VStack {
                Image(systemName: Icons.circleInCircleFilled)
                    .imageScale(.large)
            }
            
            VStack {
                Text(Strings.JourneyPage.Destination)
                    .bold()
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(journey.journeyLegs.last?.endAtName ?? "")
                    .bold()
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private func brandingColour(_ leg: JourneyLeg) -> Color {
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
}

private struct JourneyLegExpansionView: View {
    
    public var leg: JourneyLeg
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 8)
            Button(action: { withAnimation { self.isExpanded.toggle() }}) {
                HStack(alignment: .bottom) {
                    
                    if stopCounts() > 1 {
                        Image(systemName: isExpanded ? Icons.minusCircle : Icons.addCircle)
                            .tint(.blue)
                            .contentTransition(.symbolEffect(.replace))
                        Text(Strings.JourneyPage.Stops(stopCounts()))
                            .bold()
                    } else {
                        Text(Strings.JourneyPage.Stops(1))
                            .bold()
                    }
                    
                    Text(Strings.JourneyPage.Mins(leg.legDuration))
                        .font(.subheadline)
                }
                .tint(.primary)
                .contentShape(.rect)
            }
            
            if stopCounts() > 1 && isExpanded {
                VStack(alignment: .leading) {
                    ForEach(stopsToDisplay(), id: \.stopPointId) { stop in
                        HStack {
                            Rectangle()
                                .fill(brandingColour())
                                .frame(width: 12, height: 2)
                            Text(stop.stopPointName)
                                .fontDesign(.rounded)
                        }
                    }
                }
            }
            
            Spacer().frame(height: 16)
        }
    }
    
    private func stopsToDisplay() -> [JourneyStopPoint] {
        var stops = leg.legDetails.stopPoints
        stops.removeAll(where: { $0.stopPointId == leg.endAtStop?.stopPointId })
        
        return stops
    }
    
    private func stopCounts() -> Int {
        var stopCount = leg.legDetails.stopPoints.count
        if leg.legDetails.stopPoints.contains(where: { $0.stopPointId == leg.startAtStop?.stopPointId }) {
            stopCount -= 1
        }
        return stopCount
    }
    
    private func brandingColour() -> Color {
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
}

#Preview {
        
    return NavigationStack {
        JourneyDetailPage(PreviewDataJourney.PreviewJourneyResponse().journeyOptions[0])
    }
}
