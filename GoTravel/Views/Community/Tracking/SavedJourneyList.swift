//
//  SavedJourneyList.swift
//  GoTravel
//
//  Created by Tom Knighton on 21/03/2024.
//

import SwiftUI
import GoTravel_API
import GoTravel_CoreData
import GoTravel_Models
import SwiftData

public struct SavedJourneyList: View {
    
    @Environment(GlobalViewModel.self) private var globalVM
    static var descriptor: FetchDescriptor<SavedJourney> {
        let descriptor = FetchDescriptor<SavedJourney>(sortBy: [SortDescriptor(\.endedAt, order: .reverse)])
        return descriptor
    }
    @Query(descriptor) private var unsavedJourneys: [SavedJourney]
    @State private var savedJourneys: [UserSavedJourney] = []
    
    public var body: some View {
        VStack() {
            Text(Strings.Community.Journey.MyJourneys)
                .font(.headline)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 0) {
                previewSavedJourneys()
            }
            .clipShape(.rect(cornerRadius: 10))

            if unsavedJourneys.count != 0 {
                NavigationLink(value: UnsavedJourneysNav()) {
                    HStack {
                        Text(Strings.Community.Journey.UnsavedJourneys)
                            .font(.headline.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .fill(.red)
                                .frame(width: 18, height: 18)
                            Text(String(describing: unsavedJourneys.count))
                                .font(.caption)
                                .tint(.white)
                        }
                        
                        
                        Image(systemName: Icons.chevronRight)
                            .foregroundStyle(.gray)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.layer2)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .accessibilityElement(children: .ignore)
                .accessibilityElement()
                .accessibilityLabel(Strings.Community.Journey.UnsavedBtnLabel(unsavedJourneys.count))
                .accessibilityLabel(Strings.Community.Journey.UnsavedBtnHint)
            }
        }
        .fontDesign(.rounded)
        .task {
            await load()
        }
        .onChange(of: globalVM.saveTripId) { _, _ in
            Task {
                await load()
            }
        }
    }

    
    @ViewBuilder
    private func previewSavedJourneys() -> some View {
        
        if savedJourneys.isEmpty {
            ContentUnavailableView(Strings.Community.Journey.NoSaved, systemImage: Icons.map_circle, description: Text(Strings.Community.Journey.NoSavedMsg))
        }
        
        ForEach(savedJourneys, id: \.journeyId) { journey in
            NavigationLink(value: SavedJourneyNavModel(journey: journey)) {
                row(journey)
            }
            .tint(.primary)
            Divider()
        }
    }
    
    @ViewBuilder
    private func row(_ journey: UserSavedJourney) -> some View {
        HStack() {
            VStack {
                Text(journey.journeyName)
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
    }
    
    private func load() async {
        do {
            self.savedJourneys = try await JourneyService.GetTrips()
        } catch {
            print(error)
        }
    }
}

#if DEBUG
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SavedJourney.self, configurations: config)
    
    for j in PreviewSavedJourneyData.savedJourneys {
        container.mainContext.insert(j)
    }
    let global = GlobalViewModel()
    global.currentUser = CurrentUser(userId: "auth0|Id", userName: "tomknighton", userEmail: "tomknighton@icloud.com", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", dateCreated: Date())
    
    return NavigationStack {
        ScrollView {
            SavedJourneyList()
                .modelContainer(container)
        }
        .contentMargins(.horizontal, 16, for: .scrollContent)
        .environment(global)
    }
}
#endif
