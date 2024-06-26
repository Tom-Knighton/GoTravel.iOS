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
import CoreLocation

@Observable
public class JourneyManager {
    
    @ObservationIgnored
    public static let shared = JourneyManager()
    
    public var isInJourney: Bool {
        get { current != nil }
    }
    public var current: CurrentTrackingData? = nil
    
    /// Enables background location monitoring and starts recording journey data to SwiftData/CoreData
    @MainActor
    public func startTrackingJourney() async {
        let container = GoTravelCoreData.shared.container
        
        guard LocationManager.shared.isLocationGranted else {
            fatalError("")
        }
        
        LocationManager.shared.monitorBackground()
        
        let context = container.mainContext
        
        do {
            try context.delete(model: CurrentTrackingData.self)
            
            let trackingData = CurrentTrackingData(startedAt: Date(), coordinates: [])
            context.insert(trackingData)
            self.current = trackingData
        }
        catch {
            print(error)
        }
    }

    @MainActor
    public func currentJourney() async -> CurrentTrackingData? {
        let container = GoTravelCoreData.shared.container
        let context = container.mainContext

        let descriptor = FetchDescriptor<CurrentTrackingData>()
        return try? context.fetch(descriptor).first
    }

    @MainActor
    public func endTracking() async {
        let container = GoTravelCoreData.shared.container
        let context = container.mainContext

        guard let current = await self.currentJourney() else {
            return
        }
        
        let startTrack = current.coordinates.sorted(by: { $0.time < $1.time }).first
        let endTrack = current.coordinates.sorted(by: { $0.time < $1.time}).last
        
        var name: String? = nil
        
        if let startTrack, let endTrack {
            let startName = try? await CLGeocoder().reverseGeocodeLocation(.init(latitude: startTrack.latitude, longitude: startTrack.longitude)).first?.name
            let endName = try? await CLGeocoder().reverseGeocodeLocation(.init(latitude: endTrack.latitude, longitude: endTrack.longitude)).first?.name
            
            var tempName: String = ""
            if let startName {
                tempName = startName
                if endName != nil {
                    tempName += " to "
                }
            }
            if let endName {
                tempName += endName
            }
            
            if !tempName.isEmpty {
                name = tempName
            }
        }
        
        let savedJourney = SavedJourney(name: name, startedAt: current.startedAt, endedAt: Date(), coordinates: current.coordinates.compactMap { .init(time: $0.time, latitude: $0.latitude, longitude: $0.longitude, speed: $0.speed, direction: $0.direction)}, lines: [])
        context.insert(savedJourney)
        context.delete(current)
        try? context.save()
        self.current = nil
        LocationManager.shared.pauseBackgroundMonitoring()

        
        let lastInsert = try? context.fetch(FetchDescriptor<SavedJourney>())
        if let lastId = lastInsert?.last {
            GlobalViewModel.shared.saveTripId = GVMSaveTripDetails(saveTripId: lastId.id, canClose: false)
        }
    }
    
    @MainActor
    public func exportJourney(_ journey: SavedJourney) async {
        let container = GoTravelCoreData.shared.container
        let context = container.mainContext
        
        context.delete(journey)
        try? context.save()
    }
}
