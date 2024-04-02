//
//  UnsavedJourneysView.swift
//  GoTravel
//
//  Created by Tom Knighton on 31/03/2024.
//

import SwiftData
import GoTravel_CoreData
import SwiftUI

public struct UnsavedJourneysView: View {
    
    static var descriptor: FetchDescriptor<SavedJourney> {
        let descriptor = FetchDescriptor<SavedJourney>(sortBy: [SortDescriptor(\.endedAt, order: .reverse)])
        return descriptor
    }
    @Query(descriptor) private var unsavedJourneys: [SavedJourney]
    @State private var unsavedInfo: Bool = false
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            ScrollView {
                VStack {
                    HStack {
                        Text(Strings.Community.Journey.UnsavedJourneys)
                            .font(.headline)
                            .bold()
                        Button(action: { self.unsavedInfo = true }) {
                            Image(systemName: Icons.infoCircle)
                        }
                        Spacer()
                    }
                    .flipsForRightToLeftLayoutDirection(true)
                   
                    VStack(spacing: 0) {
                        previewUnsubmittedJourneys()
                    }
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
            .navigationTitle(Strings.Community.Journey.UnsavedJourneys)
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .alert(Strings.Misc.Information, isPresented: $unsavedInfo) {
                Button(action: {}) { Text(Strings.Misc.Ok) }
            } message: {
                Text(Strings.Community.Journey.UnsavedInfo)
            }
        }
        
    }
    
    @ViewBuilder
    private func row(_ journey: SavedJourney) -> some View {
        HStack() {
            VStack {
                Text(journey.name ?? Strings.JourneyPage.Journey.toString())
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                HStack(alignment: .center) {
                    Text(journey.startedAt.formatted(date: .abbreviated, time: .omitted))
                    Image(systemName: Icons.circleFill)
                        .font(.caption2)
                    Text(journey.endedAt.friendlyDifference(journey.startedAt))
                        .font(.caption)
                    
                    Spacer()
                }
                .font(.caption)
                .flipsForRightToLeftLayoutDirection(true)
            }
            
            Image(systemName: Icons.chevronRight)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(Color.layer2)
        .accessibilityElement(children: .ignore)
        .accessibilityElement()
        .accessibilityLabel(Strings.Community.Accessibility.UnsavedJourney(journey.name ?? Strings.JourneyPage.Journey.toString(), startedAt: journey.startedAt))
        .accessibilityHint(Strings.Community.Accessibility.UnsavedJourneyHint)
    }
    
    @ViewBuilder
    private func previewUnsubmittedJourneys() -> some View {
        ForEach(unsavedJourneys, id: \.id) { journey in
            row(journey)
                .onTapGesture {
                    GlobalViewModel.shared.saveTripId = GVMSaveTripDetails(saveTripId: journey.id, canClose: true)
                }
            Divider()
        }
    }
}
