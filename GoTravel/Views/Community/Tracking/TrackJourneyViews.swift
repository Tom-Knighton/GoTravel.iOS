//
//  TrackJourneyViews.swift
//  GoTravel
//
//  Created by Tom Knighton on 19/03/2024.
//

import SwiftUI
import SwiftData
import GoTravel_CoreData
import MapKit



public struct TrackingJourneyView: View {
    
    @Environment(JourneyManager.self) private var journeyVM
    private var onDismiss: () -> Void
    
    public init (onDismiss: @escaping () -> Void) {
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(Strings.Community.Journey.TrackingJourney)
                        .font(.title3.bold())
                        .fontDesign(.rounded)
                    Spacer()
                    Button(action: { self.onDismiss() }) {
                        ExitButtonView()
                            .shadow(radius: 3)
                    }
                }
                .flipsForRightToLeftLayoutDirection(true)
               
                Text(Strings.Community.Journey.StillTracking)
                    .font(.caption)
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Button(action: { Task { await journeyVM.endTracking() }}) {
                        Text(Strings.Community.Journey.EndJourney)
                            .font(.caption)
                    }
                    .buttonStyle(.borderedProminent)
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

public struct DebugPastJourneys: View {
    
    @Environment(GlobalViewModel.self) private var globalVM
    @Query private var savedJourneys: [SavedJourney]
    
    public var body: some View {
        VStack {
            ForEach(savedJourneys, id: \.endedAt) { journey in
                VStack {
                    Text(journey.startedAt, format: .dateTime)
                    Text(journey.endedAt, format: .dateTime)
                    
                }
                .onTapGesture {
                    globalVM.addToCurrentNavStack(journey.id)
                }
            }
        }
    }
}

public struct DebugJourney: View {
    
    @State private var journey: SavedJourney?
    private var id: PersistentIdentifier

    public init(id: PersistentIdentifier) {
        self.id = id
    }
    
    public var body: some View {
        Map {
            if let journey {
                MapPolyline(coordinates: journey.coordinates.sorted(by: { a, b in
                    a.time < b.time
                }).compactMap { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)})
                    .stroke(.red, style: .init(lineWidth: 8, lineCap: .round))
            }
        }
        .ignoresSafeArea()
        .navigationTitle(journey?.name ?? journey?.startedAt.formatted() ?? "Loading...")
        .task {
            let container = GoTravelCoreData.shared.container
            let context = await container.mainContext
            
            let retrieved: SavedJourney? = context.registeredModel(for: id)
            self.journey = retrieved
        }
    }
}
