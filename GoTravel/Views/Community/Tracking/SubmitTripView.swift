//
//  SubmitTripView.swift
//  GoTravel
//
//  Created by Tom Knighton on 27/03/2024.
//

import SwiftUI
import SwiftData
import GoTravel_CoreData
import GoTravel_Models
import GoTravel_API
import CoreLocation
import MapKit
import CompactSlider
import WrappingHStack

public struct SubmitTripView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var journey: SavedJourney?
    @State private var trimLower: Double = 0
    @State private var trimUpper: Double = 100
    @State private var isLoading: Bool = false
    @State private var successAlert: Bool = false
    @State private var apiJourney: UserSavedJourney? = nil
    
    @State private var lines: [Line] = []
    @State private var showLineSheet: Bool = false
    @State private var showLinesInfo: Bool = false
    
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
                        trimView()
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
            .sheet(isPresented: $showLineSheet, content: {
                NavigationStack {
                    LineSearchView(selectedLines: $lines)
                }
            })
            .alert("Info", isPresented: $showLinesInfo, actions: {
                Button(action: {}) {
                    Text("Ok")
                }
            }, message: {
                Text("When you submit your journey, you can tell GoTravel which lines you travelled on, these will be compared against the route you took and you can get extra points for submitting this information")
            })
            .alert("Success!", isPresented: $successAlert, presenting: self.apiJourney) { _ in
                Button(action: { self.dismiss() }) {
                    Text("Ok")
                }
            } message: { data in
                Text("You got \(data.pointsReceived) points for this journey!")
            }

        }
        
    }
    
    @ViewBuilder
    private func mapPreview(_ journey: SavedJourney) -> some View {
        Map {
            MapPolyline(points: selectedCoords().compactMap { .init($0) }, contourStyle: .straight)
                .stroke(.red, lineWidth: 2)
            
        }
        .allowsHitTesting(false)
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 10)
    }
    
    @ViewBuilder
    private func trimView() -> some View {
        VStack {
            Text("Trim Trip:")
                .font(.headline.bold())
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                CompactSlider(from: $trimLower, to: $trimUpper, in: 0...100, scaleVisibility: .always) {
                    Spacer()
                }
                .compactSliderStyle(.yellow)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.layer2)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
    }
    
    @ViewBuilder
    private func detailsView(_ journey: SavedJourney) -> some View {
        Grid {
            GridRow {
                VStack {
                    Text("Started:")
                        .font(.caption)
                    Text(journey.startedAt, format: .dateTime)
                        .font(.headline)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
                
                VStack {
                    Text("Ended:")
                        .font(.caption)
                    Text(journey.endedAt, format: .dateTime)
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
                VStack(spacing: 8) {
                    HStack {
                        Text("Lines:")
                        Spacer()
                        Button(action: { self.showLinesInfo = true }) {
                            Image(systemName: Icons.infoCircle)
                        }
                    }
                    .flipsForRightToLeftLayoutDirection(true)
                    
                    if lines.isEmpty {
                        Text("Add the lines you travelled on to increase your points!")
                    }
                    
                    WrappingHStack(alignment: .leading) {
                        ForEach(self.lines, id: \.lineId) { line in
                            Button(action: { self.removeLine(line.lineId) }) {
                                Text(line.lineName)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal)
                                    .background(Color(hex: line.linePrimaryColour ?? "") ?? Color.layer2)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                            .tint(.white)
                        }
                    }
                    
                    Button(action:{ self.showLineSheet = true }) {
                        Text("Add Line")
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
                .gridCellColumns(3)
            }
            
            GridRow {
                Button(action: { Task {
                    await save(journey)
                }}) {
                    if self.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Submit")
                            .bold()
                            .fontDesign(.rounded)
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(self.isLoading || selectedCoords().count < 2)
                .buttonStyle(.borderedProminent)
                .tint(.orange)
                .gridCellColumns(3)
            }
            
            GridRow {
                Button(action: { modelContext.delete(journey); self.dismiss(); }) {
                    Text("Delete")
                        .bold()
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity)
                }
                .disabled(self.isLoading)
                .buttonStyle(.bordered)
                .tint(.red)
                .gridCellColumns(3)
            }
        }
        .multilineTextAlignment(.center)
    }
    
    private func distance(_ journey: SavedJourney) -> Double {
        let actual = selectedCoords()
        let distance = zip(actual, actual.dropFirst())
            .map { CLLocation(latitude: $0.0.latitude, longitude: $0.0.longitude)
                .distance(from: .init(latitude: $0.1.latitude, longitude: $0.1.longitude))}
            .reduce(0, +)
        return (distance * 10).rounded() / 10
    }
    
    private func save(_ journey: SavedJourney) async {
        guard !isLoading else { return }
        self.isLoading = true
        defer { self.isLoading = false }
        
        let trip = SaveUserTripCommand(name: journey.name ?? "Unnamed Trip", startedAt: journey.startedAt, endedAt: journey.endedAt, averageSpeed: journey.coordinates.compactMap { $0.speed }.reduce(0, +), lines: [], coordinates: selectedCoords().compactMap { [$0.longitude, $0.latitude] })
        
        self.apiJourney = try? await JourneyService.SaveTrip(trip, id: "\(journey.id)")
        if apiJourney != nil {
            self.successAlert = true
        }
    }
    
    private func selectedCoords() -> [CLLocationCoordinate2D] {
        
        guard let journey else { return [] }
        
        let coords = journey.coordinates.sorted(by: { $0.time < $1.time }).compactMap { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)}
        let prefixCount = Int(Double(coords.count) * self.trimLower / 100)
        let suffixCount = Int(Double(coords.count) * self.trimUpper / 100)

        return coords.dropFirst(prefixCount).dropLast(coords.count - suffixCount)
    }
    
    private func removeLine(_ lineId: String) {
        self.lines.removeAll(where: { $0.lineId == lineId })
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
            SubmitTripView(id: journey.id)
                .modelContainer(container)
        }
    }
}

#endif
