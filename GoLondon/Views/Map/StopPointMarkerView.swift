//
//  StopPointMarkerView.swift
//  GoLondon
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
                    .foregroundStyle(Color.red)
                circleContent()
                    .bold()
                    .shadow(radius: 3)
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
        case .bus(_):
            Image(systemName: Icons.bus)
        case .train(_):
            Image(systemName: Icons.train)
        }
    }
}
