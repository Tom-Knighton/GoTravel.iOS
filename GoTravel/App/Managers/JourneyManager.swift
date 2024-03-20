//
//  JourneyManager.swift
//  GoTravel
//
//  Created by Tom Knighton on 19/03/2024.
//

import SwiftUI
import Observation
import SwiftData
import GoTravel_CoreData

@Observable
public class JourneyManager {
    
    @ObservationIgnored
    public static let shared = JourneyManager()
    
    /// Enables background location monitoring and starts recording journey data to SwiftData/CoreData
    public func startTrackingJourney() async {
        let container = GoTravelCoreData.shared.container
        
        guard LocationManager.shared.isLocationGranted else {
            fatalError("Smelly :(")
        }
        
        LocationManager.shared.manager.allowsBackgroundLocationUpdates = true
        LocationManager.shared.manager.showsBackgroundLocationIndicator = true
        
        let context = await container.mainContext
        
        do {
            try context.delete(model: CurrentTrackingData.self)
            
            let trackingData = CurrentTrackingData(startedAt: Date(), coordinates: [])
            context.insert(trackingData)
        }
        catch {
            print(error)
        }
        
        let currentTrackingData = CurrentTrackingData(startedAt: Date(), coordinates: [])
    }
    
    public func currentJourney() async -> CurrentTrackingData? {
        let container = GoTravelCoreData.shared.container
        let context = await container.mainContext

        let descriptor = FetchDescriptor<CurrentTrackingData>()
        return try? context.fetch(descriptor).first
    }
    
}
