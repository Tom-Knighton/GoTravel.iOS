//
//  LineModeFilterViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 06/12/2023.
//

import SwiftUI
import Observation
import GoTravel_Models
import GoTravel_API
import GoTravel_CoreData
import SwiftData
import CoreLocation

@Observable
public class LineModeFilterViewModel {
    
    public var lineModeGroups: [LineModeGroup] = []
    public var errorMessage: LocalizedStringKey? = nil
    public var isLoading: Bool = false
    
    @ObservationIgnored
    private let fetchDescriptor = FetchDescriptor<LineModeCache>()
    
    @ObservationIgnored
    private let context: ModelContext
    
    init() {
        context = GoTravelCoreData.shared.context
    }
    
    /// Loads line modes for a specified coordinate
    public func load(for coordinates: CLLocationCoordinate2D? = nil) {
        let oneWeekAgo: Date = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        Task {
            do {
                self.isLoading = true
                let cached = try context.fetch(self.fetchDescriptor)
                
                if cached.contains(where: { $0.cacheTime < oneWeekAgo }) {
                    throw "Cache line modes out of date"
                }
                
                if cached.isEmpty {
                    throw "No items in line mode cache"
                }
                
                let modes = cached.compactMap { $0.toLineMode() }
                await self.loadLineModeGroups(from: modes, coordinate: coordinates)
                self.isLoading = false
            } catch {
                Task {
                    if let modes = await self.fetchLineModeGroups() {
                        await self.loadLineModeGroups(from: modes.flatMap { $0.lineModes }, coordinate: coordinates)
                    } else {
                        self.errorMessage = Strings.Errors.NoLineModesAPI
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    @MainActor
    public func toggleLineMode(lineMode: String) {
        do {
            let predicate = #Predicate<HiddenLineMode> { toggle in toggle.lineModeName == lineMode }
            let descriptor = FetchDescriptor(predicate: predicate)
            let existingToggles = try? context.fetch(descriptor)
            if let existingToggle = existingToggles?.first {
                existingToggle.hidden = !existingToggle.hidden
                try context.save()
            } else {
                let newToggle = HiddenLineMode(lineModeName: lineMode, hidden: true)
                context.insert(newToggle)
                try context.save()
            }
            
        } catch {
            print("error saving hidden line mode: \(lineMode)")
        }
    }
    
    private func fetchLineModeGroups() async -> [LineModeGroup]? {
        do {
            let results = try await LineModeService.GetAllLineModes(lat: nil, lon: nil)
            self.errorMessage = nil
            self.isLoading = false
            return results
        } catch {
            self.lineModeGroups = []
            self.errorMessage = Strings.Errors.NoLineModesAPI
            self.isLoading = false
            return nil
        }
    }
    
    private func loadLineModeGroups(from: [LineMode], coordinate: CLLocationCoordinate2D? = nil) async {
        
        var currentArea = "UK"
        if let coords = coordinate ?? LocationManager.shared.manager.location?.coordinate {
            currentArea = (try? await LineModeService.GetArea(lat: coords.latitude, lon: coords.longitude)) ?? "UK"
        }
        
        var groups: [LineModeGroup] = []
        
        let nearbyModes = from.filter { $0.primaryAreaName == currentArea }
        if nearbyModes.count > 0 {
            let nearbyGroup = LineModeGroup(areaName: Strings.Map.LineModeFilterNearby.toString(), lineModes: nearbyModes)
            groups.append(nearbyGroup)
        }
        
        let otherLineModes = from.filter { $0.primaryAreaName != (currentArea) }
        let otherGroup = LineModeGroup(areaName: Strings.Map.LineModeFilterOthers.toString(), lineModes: otherLineModes)
        groups.append(otherGroup)
        
        self.lineModeGroups = groups
    }
}
