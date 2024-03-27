//
//  SavedJourneyData.swift
//  GoTravel
//
//  Created by Tom Knighton on 21/03/2024.
//

import Foundation
import GoTravel_CoreData
import SwiftData

#if DEBUG
public struct PreviewSavedJourneyData {
    
    public static let timeAgo = Calendar.current.date(byAdding: .minute, value: -55, to: Date())
    public static let savedJourneys: [SavedJourney] = [
        .init(name: "Test", startedAt: timeAgo!, endedAt: Date(), coordinates: [], lines: []),
        .init(name: "Test 2", startedAt: timeAgo!, endedAt: Date(), coordinates: [], lines: []),
        .init(name: "Test 3", startedAt: timeAgo!, endedAt: timeAgo!, coordinates: [], lines: [])
    ]
    
    public static func container() -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: SavedJourney.self, configurations: config)
        
        return container
    }
}
#endif
