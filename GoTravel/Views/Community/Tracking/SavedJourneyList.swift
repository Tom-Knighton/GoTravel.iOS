//
//  SavedJourneyList.swift
//  GoTravel
//
//  Created by Tom Knighton on 21/03/2024.
//

import SwiftUI
import GoTravel_CoreData
import GoTravel_Models
import SwiftData

public struct SavedJourneyList: View {
    
    static var descriptor: FetchDescriptor<SavedJourney> {
        var descriptor = FetchDescriptor<SavedJourney>(sortBy: [SortDescriptor(\.endedAt, order: .reverse)])
        descriptor.fetchLimit = 5
        return descriptor
    }
    @Query(descriptor) private var savedJourneys: [SavedJourney]
    
    public var body: some View {
        VStack(spacing: 0) {
            previewSavedJourneys()
        }
        .fontDesign(.rounded)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    @ViewBuilder
    private func previewSavedJourneys() -> some View {
        ForEach(savedJourneys, id: \.id) { journey in
            NavigationLink(value: SavedJourneyNavModel(savedJourneyId: journey.id)) {
                row(journey)
            }
            .tint(.primary)
            Divider()
        }
        
        Button(action: {}) {
            Text("View All")
                .bold()
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.layer2)
        }
    }
    
    @ViewBuilder
    private func row(_ journey: SavedJourney) -> some View {
        HStack() {
            VStack {
                Text(journey.name ?? "Journey")
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                HStack(alignment: .center) {
                    Text(journey.startedAt.formatted(date: .abbreviated, time: .omitted))
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                    Text(journey.endedAt.friendlyDifference(journey.startedAt))
                        .font(.caption)
                    
                    Spacer()
                }
                .font(.caption)
                .flipsForRightToLeftLayoutDirection(true)
            }
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(Color.layer2)
    }
}

#if DEBUG
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SavedJourney.self, configurations: config)
    
    for j in PreviewSavedJourneyData.savedJourneys {
        container.mainContext.insert(j)
    }
    
    return NavigationStack {
        ScrollView {
            SavedJourneyList()
                .modelContainer(container)
        }
        .contentMargins(.horizontal, 16, for: .scrollContent)
    }
}
#endif
