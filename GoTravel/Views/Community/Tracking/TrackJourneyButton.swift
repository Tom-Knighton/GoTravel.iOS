//
//  StartTrackJourneyButton.swift
//  GoTravel
//
//  Created by Tom Knighton on 21/03/2024.
//

import SwiftUI
import GoTravel_CoreData

public struct TrackJourneyButton: View {
    
    @Environment(JourneyManager.self) private var journeyVM
    
    public var body: some View {
        ZStack {
            
            if journeyVM.current != nil {
                Button(action: { Task { await stopTracking() }}) {
                    Text(Strings.Community.Journey.StopTracking)
                        .bold()
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            } else {
                Button(action: { Task { await journeyVM.startTrackingJourney() }}) {
                    Text(Strings.Community.Journey.StartTracking)
                        .padding(.vertical, 8)
                        .foregroundStyle(.white)
                        .bold()
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(colors: [.orange, .green], startPoint: .bottomLeading, endPoint: .topTrailing))
                                .shadow(color: .orange, radius: 3)
                        )
                }
                .buttonStyle(.plain)
            }
        }
    }
    
    private func stopTracking() async {
        await journeyVM.endTracking()
    }
}

#Preview {
    
    let journeyVM = JourneyManager()
    journeyVM.current = CurrentTrackingData(startedAt: Date(), coordinates: [])
    
    return TrackJourneyButton()
        .environment(journeyVM)
}
