//
//  SavedJourneyView.swift
//  GoTravel
//
//  Created by Tom Knighton on 21/03/2024.
//

import SwiftUI
import GoTravel_Models
import MapKit
import WrappingHStack

public struct SavedJourneyView: View {
    
    @State private var journey: UserSavedJourney
    
    public init(journey: UserSavedJourney) {
        self._journey = State(wrappedValue: journey)
    }
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            ScrollView {
                VStack {
                    if journey.isUnderReview {
                        HStack {
                            Spacer()
                            Image(systemName: Icons.exclamationMarkTriangle)
                            Text(Strings.Community.Journey.UnderReviewPending)
                                .bold()
                            Spacer()
                        }
                        .foregroundStyle(.white)
                        .padding(.vertical, 6)
                        .background(Color.yellow)
                        .clipShape(.rect(cornerRadius: 10))
                        .shadow(radius: 3)
                    }
                    mapPreview(journey)
                    detailsView(journey)
                }
            }
            .fontDesign(.rounded)
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .navigationTitle(journey.journeyName)
            .toolbarBackground(.automatic, for: .navigationBar)
            .toolbarBackground(Color.layer1, for: .navigationBar)
        }
        
    }
    
    @ViewBuilder
    private func mapPreview(_ journey: UserSavedJourney) -> some View {
        Map {
            let coords = journey.coordinates.compactMap { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])}
            MapPolyline(points: coords.compactMap { .init($0) }, contourStyle: .straight)
                .stroke(.red, lineWidth: 2)
        }
        .allowsHitTesting(false)
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 10)
    }
    
    @ViewBuilder
    private func detailsView(_ journey: UserSavedJourney) -> some View {
        Grid {
            GridRow {
                VStack {
                    Text(Strings.Community.Journey.Started)
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
                    Text(Strings.Community.Journey.Ended)
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
                    Text(Strings.Community.Journey.Distance)
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
                    Text(Strings.Community.Journey.Points)
                        .font(.caption)
                    Text(String(describing: journey.pointsReceived))
                        .bold(journey.isUnderReview == false)
                    
                    if journey.isUnderReview {
                        Text(Strings.Community.Journey.UnderReview)
                            .bold()
                        Text(Strings.Community.Journey.UnderReviewMessage)
                        if let note = journey.note {
                            Text(note)
                        }
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
                .gridCellColumns(3)
            }
            
            if !journey.lines.isEmpty {
                GridRow {
                    VStack(spacing: 8) {
                        Text(Strings.Community.Journey.Lines)
                            .frame(maxWidth: .infinity)
                        
                        WrappingHStack(alignment: .leading) {
                            ForEach(journey.lines, id: \.lineId) { line in
                                Text(line.lineName)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal)
                                    .background(Color(hex: line.linePrimaryColour ?? "") ?? Color.layer2)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.layer2)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(radius: 3)
                    .gridCellColumns(3)
                }
            }
        }
        .multilineTextAlignment(.center)
    }
    
    private func distance(_ journey: UserSavedJourney) -> Double {
        let ordered = journey.coordinates
        let distance = zip(ordered, ordered.dropFirst())
            .map { CLLocation(latitude: $0.0[1], longitude: $0.0[0])
                .distance(from: .init(latitude: $0.1[1], longitude: $0.1[0]))}
            .reduce(0, +)
        return (distance * 10).rounded() / 10
    }
}

#if DEBUG
#Preview {
    MainActor.assumeIsolated {
        return NavigationStack {
            SavedJourneyView(journey: .init(journeyId: "", journeyName: "", startedAt: Date(), endedAt: Date(), pointsReceived: 50, isUnderReview: false, note: nil, coordinates: [], lines: []))
        }
    }
    
}
#endif
