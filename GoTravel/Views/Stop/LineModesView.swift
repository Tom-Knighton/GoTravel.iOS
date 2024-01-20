//
//  LineModesView.swift
//  GoTravel
//
//  Created by Tom Knighton on 18/01/2024.
//

import SwiftUI
import GoTravel_Models
import WrappingHStack

public struct LineModesView: View {
    
    public var stop: StopPoint
    
    
    public var body: some View {
        let normalModes = getLineModesToDisplay()
        VStack {
            WrappingHStack(alignment: .leading) {
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
                
                individualModeLines()
            }
            
            bikeLineModesView()
        }
    }
    
    @ViewBuilder
    private func individualModeLines() -> some View {
        let individualModes = getModesDisplayedIndividually()
        ForEach(individualModes, id: \.lineModeName) { mode in
            Divider()
            ForEach(mode.lines, id: \.lineName) { line in
                Group {
                    if mode.hasFlag("LLV_DisplaysLineNames") {
                        Text(line.lineName)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .font(.footnote)
                    } else {
                        Rectangle()
                            .fill(Color(hex: line.linePrimaryColour) ?? Color(hex: mode.branding.lineModeBackgroundColour) ?? .red)
                            .frame(width: 20, height: 20)
                    }
                }
                .background(Color(hex: line.linePrimaryColour) ?? Color(hex: mode.branding.lineModeBackgroundColour) ?? .red)
                .clipShape(.rect(cornerRadius: 5))
                .shadow(radius: 3)
                .accessibilityLabel(Strings.Accessibility.MapLineRoute(line.lineName))
            }
        }
    }
    
    @ViewBuilder
    private func bikeLineModesView() -> some View {
        VStack {
            let bikeLineModes = self.stop.stopPoint.lineModes.filter { $0.hasFlag("IsBikeLike") }
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
            
            if case .bike(let bikeStopPoint) = stop {
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
    
    private func getLineModesToDisplay() -> [LineMode] {
        let lineModesToDisplay = self.stop.stopPoint.lineModes
        
        return lineModesToDisplay
    }
    
    private func getModesDisplayedIndividually() -> [LineMode] {
        let individualLineModes = self.stop.stopPoint.lineModes.filter { $0.hasFlag("LLV_DisplaysLines") }
        return individualLineModes
    }
}
