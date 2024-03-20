//
//  TrackJourneyViews.swift
//  GoTravel
//
//  Created by Tom Knighton on 19/03/2024.
//

import SwiftUI

public struct TrackJourneyButton: View {
    
    @Environment(JourneyManager.self) private var journeyVM
    
    public var body: some View {
        ZStack {
            Button(action: { Task { await journeyVM.startTrackingJourney() }}) {
                Text("Start Tracking Journey")
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

public struct TrackingJourneyView: View {
    public var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Tracking Journey")
                        .font(.title3.bold())
                        .fontDesign(.rounded)
                    Spacer()
                    Button(action: {}) {
                        ExitButtonView()
                            .shadow(radius: 3)
                    }
                }
                .flipsForRightToLeftLayoutDirection(true)
               
                Text("You're tracking a journey, tap below to end it now, or dismiss this notification if you're still on your journey 😀")
                    .font(.caption)
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Button(action: {}) {
                        Text("End Journey")
                            .font(.caption)
                    }
                    .buttonStyle(.borderedProminent)
                    Text("1h 20m")
                        .font(.caption)
                        .bold()
                        .fontDesign(.rounded)
                    Spacer()
                }
               
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color.layer2)
            .background(Color.layer2.shadow(radius: 3))
            Spacer()
        }
    }
}

#Preview {
    ZStack {
        Color.blue.ignoresSafeArea(edges: .all)
        TrackingJourneyView()
    }
}
