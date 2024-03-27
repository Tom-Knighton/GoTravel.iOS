//
//  SavedJourneyView.swift
//  GoTravel
//
//  Created by Tom Knighton on 21/03/2024.
//

import SwiftUI
import SwiftData
import GoTravel_CoreData
import MapKit

public struct SavedJourneyView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var journey: SavedJourney?
    private var id: PersistentIdentifier
    
    public init(id: PersistentIdentifier) {
        self.id = id
    }
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            ScrollView {
                VStack {
                    if let journey {
                        mapPreview(journey)
                        detailsView(journey)
                    }
                }
            }
            .fontDesign(.rounded)
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .navigationTitle(journey?.name ?? journey?.startedAt.formatted() ?? "Loading...")
            .toolbarBackground(.automatic, for: .navigationBar)
            .toolbarBackground(Color.layer1, for: .navigationBar)
            .task {
                let context = modelContext
                
                let retrieved: SavedJourney? = context.registeredModel(for: id)
                self.journey = retrieved
            }
        }
        
    }
    
    @ViewBuilder
    private func mapPreview(_ journey: SavedJourney) -> some View {
        Map {
            let coords = journey.coordinates.sorted(by: { $0.time < $1.time }).compactMap { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)}
            MapPolyline(points: coords.compactMap { .init($0) }, contourStyle: .straight)
                .stroke(.red, lineWidth: 2)
        }
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 10)
    }
    
    @ViewBuilder
    private func detailsView(_ journey: SavedJourney) -> some View {
        HStack {
            Text("Started:") +
            Text(" ") +
            Text(journey.startedAt, format: .dateTime)
            Spacer()
        }
        .font(.caption)
        .flipsForRightToLeftLayoutDirection(true)
        
        HStack {
            Text("Ended:") +
            Text(" ") +
            Text(journey.endedAt, format: .dateTime)
            Spacer()
        }
        .font(.caption)
        .flipsForRightToLeftLayoutDirection(true)
        
        Grid {
            GridRow {
                VStack {
                    Text("Points:")
                        .font(.caption)
                    Text("Awaiting Moderation")
                        .font(.headline)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
                
                VStack {
                    Text("Distance:")
                        .font(.caption)
                    Text(Measurement<UnitLength>(value: distance(journey), unit: .meters), format: .measurement(width: .wide))
                        .font(.headline)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
            }
            
            GridRow {
                VStack {
                    Text("Privacy:")
                        .font(.caption)
                    Text("Private")
                        .font(.headline)
                    Button(action: {}) {
                        Text("Make Public")
                            .font(.caption)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .gridCellColumns(2)
                .shadow(radius: 3)
            }
        }
        .multilineTextAlignment(.center)
    }
    
    private func distance(_ journey: SavedJourney) -> Double {
        let ordered = journey.coordinates.sorted(by: { $0.time < $1.time })
        let distance = zip(ordered, ordered.dropFirst())
            .map { CLLocation(latitude: $0.0.latitude, longitude: $0.0.longitude)
                .distance(from: .init(latitude: $0.1.latitude, longitude: $0.1.longitude))}
            .reduce(0, +)
        return (distance * 10).rounded() / 10
    }
}

#if DEBUG
#Preview {
    MainActor.assumeIsolated {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: SavedJourney.self, configurations: config)
        
        var journey = PreviewSavedJourneyData.savedJourneys.first!
        container.mainContext.insert(journey)
        var descriptor: FetchDescriptor<SavedJourney> {
            var descriptor = FetchDescriptor<SavedJourney>(sortBy: [SortDescriptor(\.endedAt, order: .reverse)])
            descriptor.fetchLimit = 1
            return descriptor
        }
        journey = try! container.mainContext.fetch(descriptor).first!
        try! container.mainContext.save()
        
        return NavigationStack {
            SavedJourneyView(id: journey.id)
                .modelContainer(container)
        }
    }
    
}
#endif
