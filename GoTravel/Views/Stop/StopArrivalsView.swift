//
//  StopArrivalsView.swift
//  GoTravel
//
//  Created by Tom Knighton on 18/01/2024.
//

import SwiftUI
import GoTravel_Models

public struct StopArrivalsView: View {
    
    @Environment(StopPointViewModel.self) private var viewModel
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOverOn
    
    public var body: some View {
        VStack {
            HStack {
                Text(Strings.StopPage.LiveTimes)
                    .font(.title3.bold())
                    .fontDesign(.rounded)
                Spacer()
                
                if viewModel.loadingArrivals {
                    ProgressView()
                        .frame(width: 26, height: 26)
                        .accessibilityHidden()
                } else {
                    if voiceOverOn {
                        Button(action: { Task { await self.viewModel.loadArrivals() } }) {
                            Image(systemName: Icons.arrow_clockwise)
                        }
                        .accessibilityLabel(Strings.Accessibility.StopManualRefreshLabel)
                    } else {
                        GaugeTimerView(countTo: 30) {
                            Task {
                                await self.viewModel.loadArrivals()
                                AccessibilityHelper.postMessage(Strings.Accessibility.StopArrivalsUpdatedMessage.toString(), messageType: .screenChanged)
                            }
                        }
                        .frame(width: 26, height: 26)
                        .onTapGesture {
                            Task {
                                await self.viewModel.loadArrivals()
                            }
                        }
                    }
                }
                
            }
            .accessibilityLabel(Strings.Accessibility.StopArrivalsLabel)
            .accessibilityHint(Strings.Accessibility.StopArrivalsHint)
            
            Spacer().frame(height: 16)
            ForEach(viewModel.arrivalLines, id: \.lineId) { line in
                LineArrivals(for: line)
                    .padding(.bottom, 8)
            }
        }
    }
    
    @ViewBuilder
    private func LineArrivals(for line: StopPointLineArrivals) -> some View {
        
        VStack {
            HStack {
                Text(line.lineName ?? line.lineMode)
                    .font(.title3.bold())
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .background(colourForLine(line.lineId))
            .accessibilityLabel(Strings.Accessibility.LineArrivalsLabel(line.lineName ?? line.lineMode))
            
            if self.viewModel.loadingArrivals {
                ProgressView()
            } else {
                if line.platforms.isEmpty {
                    Text(Strings.StopPage.CheckBoards)
                } else {
                    ForEach(line.platforms, id: \.platformName) { platform in
                        PlatformView(for: platform, isBusLike: viewModel.hasBusLikeArrivals(for: line.lineMode))
                            .padding(.horizontal, 8)
                        Divider()
                    }
                }
            }
            
            Spacer().frame(height: 8)
        }
        .background(Color.layer2)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
    }
    
    @ViewBuilder
    private func PlatformView(for platform: StopPointPlatformArrivals, isBusLike: Bool) -> some View {
        let towards = platform.friendlyTowards()
        let direction = platform.friendlyDirection()
        let platformName = platform.friendlyPlatformName()
        
        let firstArrival = platform.firstArrivalString()
        let nextArrivals = platform.nextArrivalsString()
        
        HStack {
            VStack(alignment: .leading) {
                
                if isBusLike {
                    if let towards {
                        Text(Strings.StopPage.Towards)
                            .bold()
                            .fontDesign(.rounded)
                        Text(towards)
                            .bold()
                            .fontDesign(.rounded)
                    }
                } else if let direction {
                    Text(direction)
                        .bold()
                        .fontDesign(.rounded)
                    Text(platformName)
                        .fontDesign(.rounded)
                } else {
                    Text(platformName)
                        .bold()
                        .fontDesign(.rounded)
                }
            }
            Spacer()

            VStack(alignment: .trailing) {
                if let firstArrival {
                    Text(firstArrival)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                    
                    if let nextArrivals {
                        Text(nextArrivals)
                            .fontWeight(.light)
                            .fontDesign(.rounded)
                    }
                } else {
                    Text(Strings.StopPage.CheckBoards)
                        .fontWeight(.light)
                        .fontDesign(.rounded)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityElement()
        .accessibilityAddTraits(.isStaticText)
        .accessibilityLabel(getPlatformAccessibilityLabel(name: isBusLike ? nil : platformName, directionString: isBusLike ? towards : direction, first: firstArrival, nextString: nextArrivals))
    }
    
    private func colourForLine(_ lineId: String) -> Color {
        guard let stop = viewModel.stopPoint?.stopPoint else {
            return .red
        }
        
        let lines = stop.lineModes.flatMap { $0.lines }
        let line = lines.first(where: { $0.lineId == lineId })
        
        if let line, let branding = line.linePrimaryColour, let hex = Color(hex: branding) {
            return hex
        }
        
        if line != nil, let mode = stop.lineModes.first(where: { $0.lines.contains(where: { $0.lineId == lineId })}) {
            return Color(mode.branding.lineModePrimaryColour)
        }
        
        return .red
    }
    
    private func getPlatformAccessibilityLabel(name: String?, directionString: String? = nil, first: String? = nil, nextString: String? = nil) -> String {
        var label = ""
        if let name {
            label += name
        }
        if let directionString {
            label += " - " + directionString
        }
        
        if let first {
            label += Strings.Accessibility.StopNextArrivalIs.toString() + " " + first
            if let nextString {
                label += ", " + nextString
            }
        }
                
        return label
    }
}

#Preview {
    
    let vm = StopPointViewModel()
    
    return StopArrivalsView()
        .padding(.horizontal, 16)
        .environment(vm)
        .task {
            await vm.load("HUBSRA")
            await vm.loadArrivals()
        }
}
