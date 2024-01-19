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
    
    public var body: some View {
        VStack {
            HStack {
                Text("Live Times:")
                    .font(.title3.bold())
                    .fontDesign(.rounded)
                Spacer()
            }
            
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
            
            if self.viewModel.loadingArrivals {
                ProgressView()
            } else {
                if line.platforms.isEmpty {
                    Text("Check Station Boards")
                } else {
                    ForEach(line.platforms, id: \.platformName) { platform in
                        PlatformView(for: platform)
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
    private func PlatformView(for platform: StopPointPlatformArrivals) -> some View {
        HStack {
            VStack(alignment: .leading) {
                if let direction = platform.friendlyDirection() {
                    Text(direction)
                        .bold()
                        .fontDesign(.rounded)
                    Text(platform.friendlyPlatformName())
                        .fontDesign(.rounded)
                } else {
                    Text(platform.friendlyPlatformName())
                        .bold()
                        .fontDesign(.rounded)
                }
            }
            Spacer()
            VStack {
                
            }
        }
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
