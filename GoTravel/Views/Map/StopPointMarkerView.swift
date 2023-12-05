//
//  StopPointMarkerView.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import SwiftUI

public struct StopPointMarkerView: View {
    
    let stopPoint: StopPoint
    
    public var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundStyle(stopPoint.stopPoint.mostImportantLineMode?.lineModeColour ?? .red)
                circleContent()
                    .bold()
                    .shadow(radius: 3)
                    .frame(width: 20, height: 20)
            }
            
            UnevenRoundedRectangle(bottomLeadingRadius: 10, bottomTrailingRadius: 10)
                .frame(width: 3, height: 15)
                .foregroundStyle(.primary)
        }
        .shadow(radius: 3)
    }
    
    @ViewBuilder
    func circleContent() -> some View {
        switch self.stopPoint {
        case .bike(_):
            Image(systemName: Icons.bike)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.white)
        case .bus(let busStop):
            busCircleContent(busStop)
                .foregroundStyle(.white)
        case .train(_):
            Image(systemName: Icons.train)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.white)
        }
    }
    
    @ViewBuilder
    func busCircleContent(_ bus: BusStopPoint) -> some View {
        if let letter = bus.busStopLetter {
            Text(letter)
                .bold()
                .minimumScaleFactor(0.5)
        } else if let indicator = bus.busStopIndicator {
            Text(indicator)
                .bold()
                .minimumScaleFactor(0.1)
                .frame(width: 28, height: 28)
        } else {
            Image(systemName: Icons.bus)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}
