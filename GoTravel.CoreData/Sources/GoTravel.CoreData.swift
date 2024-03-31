//
//  GoTravelCoreData.swift
//  
//
//  Created by Tom Knighton on 05/12/2023.
//

import Foundation
import SwiftData

public class GoTravelCoreData {
    
    public static var shared = GoTravelCoreData()
    
    public var container: ModelContainer = {
        let schema = Schema(AllModels)
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create ModelContainer \(error)")
        }
    }()
    
    public var context: ModelContext
    
    init() {
        context = ModelContext(container)
    }
    
    @MainActor
    func saveItem(_ item: any PersistentModel) {
        context.insert(item)
    }
    
    @MainActor
    func deleteItem(_ item: any PersistentModel) {
        let toBeDeleted = item
        context.delete(toBeDeleted)
    }
    
    private static let AllModels: [any PersistentModel.Type] =
    [
        LineModeCache.self,
        LineModeBrandingCache.self,
        HiddenLineMode.self,
        CurrentTrackingData.self,
        TrackingLocation.self,
        SavedJourney.self,
    ]
    
}
