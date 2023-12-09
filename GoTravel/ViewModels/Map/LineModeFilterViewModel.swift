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
    private let fetchDescriptor = FetchDescriptor<LineModeAreaCache>()
    
    /// Loads line modes for a specified coordinate
    public func load(for coordinates: CLLocationCoordinate2D? = nil) {
        let oneWeekAgo: Date = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        Task {
            do {
                self.isLoading = true
                let container = try ModelContainer(for: LineModeAreaCache.self)
                let context = ModelContext(container)
                let cached = try context.fetch(self.fetchDescriptor)
                
                if cached.contains(where: { $0.cacheTime < oneWeekAgo }) {
                    throw "Cache line modes out of date"
                }
                
                if cached.isEmpty {
                    throw "No items in line mode cache"
                }
                
                let modes = cached.compactMap { $0.toLineModeGroup() }
                await self.loadLineModeGroups(from: modes, coordinate: coordinates)
                self.isLoading = false
            } catch {
                Task {
                    if let modes = await self.fetchLineModeGroups() {
                        await self.loadLineModeGroups(from: modes, coordinate: coordinates)
                    } else {
                        self.errorMessage = Strings.Errors.NoLineModesAPI
                        self.isLoading = false
                    }
                }
            }
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
    
    private func loadLineModeGroups(from: [LineModeGroup], coordinate: CLLocationCoordinate2D? = nil) async {
        
        var currentArea = "UK"
        if let coords = coordinate ?? LocationManager.shared.manager.location?.coordinate {
            currentArea = (try? await LineModeService.GetArea(lat: coords.latitude, lon: coords.longitude)) ?? "UK"
        }
        
        var groups: [LineModeGroup] = []
        
        if var areaGroup = from.first(where: { $0.areaName == currentArea }) {
            areaGroup.areaName = Strings.Map.LineModeFilterNearby.toString()
            groups.append(areaGroup)
        }
        
        let otherLineModes = from.filter { $0.areaName != (currentArea) }.flatMap { $0.lineModes }
        let otherGroup = LineModeGroup(areaName: Strings.Map.LineModeFilterOthers.toString(), lineModes: otherLineModes)
        groups.append(otherGroup)
        
        self.lineModeGroups = groups
    }
}

@Observable
public class LineModeFilterAreaViewModel {
    
    public let areaName: String
    public let lineModes: [ToggledLineMode]
    
    init(areaName: String, lineModes: [ToggledLineMode]) {
        self.areaName = areaName
        self.lineModes = lineModes
    }
    
    public struct ToggledLineMode {
        let lineMode: LineMode
        let toggled: Bool
    }
}
