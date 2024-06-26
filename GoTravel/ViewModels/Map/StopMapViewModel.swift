//
//  StopMapViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 30/09/2023.
//

import SwiftUI
import Observation
import MapKit
import GoTravel_Models
import GoTravel_API
import GoTravel_CoreData
import SwiftData

@Observable
public class StopMapViewModel {
    
    public var mapPosition: MapCameraPosition
    
    @ObservationIgnored
    public var mapPannedCenter: CLLocationCoordinate2D?
    
    public var stopPoints: [StopPoint] = []
    
    //MARK: Search
    public var searchDistance: Int = 1_000
    public var searchedLocation: CLLocationCoordinate2D? = nil
    public let searchHereTip = SearchHereTip()
    public var isSearching: Bool = false
    
    //MARK: Location Banner
    public var locationBannerClosed: Bool = false
    public var locationBannerOffser: Double = .zero
    
    //MARK: Filters
    public var filterSheetOpen: Bool = false
    
    //MARK: Search Sheet
    public var sheetPosition: BottomSheetPosition = .relativeBottom(0.1)
    public var sheetPositions: [BottomSheetPosition] = [.relativeBottom(0.1), .relative(0.4), .relativeTop(1)]
    public var searchText: String = ""
    public var searchResults: [StopPoint] = []
    public var isSearchResultsLoading: Bool = false
    public var searchSheetShowNearby: Bool = true
    public var scrollToId: String? = nil
    
    public init() {
        self.mapPosition = MapCameraPosition.userLocation(fallback: .automatic)
        self.locationBannerClosed = false
        
        self.initialiseTips()
    }
    
    
    // MARK: - Tip Init
    public func initialiseTips() {
        if AppData.shared.appSessions > 20 {
            SearchHereTip.isUsedToApp = true
        }
        
        if AppData.shared.hasUsedSearchAround {
            SearchHereTip.hasCompletedActionInSession = true
        }
    }
    
    
    // MARK: - Search functions
    public func searchAtUserLoc() async {
        if let loc = LocationManager.shared.manager.location {
            await self.searchAtLocation(loc.coordinate)
        }
    }
    
    public func searchAtMapCenter() async {
        do {
            guard let mapCenter = self.mapPannedCenter else { throw "No map"}
            
            await self.searchAtLocation(mapCenter)
        } catch {
            print("error decoding results" + error.localizedDescription)
        }
    }
    
    public func goToLocation(_ coordinate: CLLocationCoordinate2D) {
        withAnimation {
            self.mapPosition = .region(.init(center: coordinate, span: .init(latitudeDelta: 0.03, longitudeDelta: 0.03)))
        }
    }
    
    @MainActor
    public func searchAtLocation(_ coordinate: CLLocationCoordinate2D) async {
        do {
            let hiddenLineModes = getHiddenLineModeNames()
            self.isSearching = true
            let result = try await StopPointService.SearchAround(lat: coordinate.latitude, lon: coordinate.longitude, radius: searchDistance, hiddenLineModes: hiddenLineModes)
           
            await MainActor.run {
                self.stopPoints = result
                self.searchedLocation = coordinate
                self.isSearching = false
                
                AccessibilityHelper.postMessage("Stop points on map refreshed", messageType: .screenChanged)
            }
        } catch {
            print("error decoding results")
            self.isSearching = false
        }
    }
    
    public func searchStopPoints(_ query: String? = nil) {
        let searchQuery = query?.trimmingCharacters(in: .whitespacesAndNewlines) ?? self.searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard searchQuery.count >= 3 else {
            return
        }
        
        self.isSearchResultsLoading = true
        Task {
            do {
                let results = try await StopPointService.Search(searchQuery)
                
                await MainActor.run {
                    self.searchResults = results
                    self.isSearchResultsLoading = false
                }            
            } catch {
                print("Error decoding search results")
                self.isSearchResultsLoading = false
            }
        }
    }
    
    public func scrollSearchResults(to stopPointId: String) {
        self.sheetPosition = self.sheetPositions[1]
        withAnimation(.spring()) {
            self.scrollToId = stopPointId
        }
    }
    
    private func getHiddenLineModeNames() -> [String] {
        let context = GoTravelCoreData.shared.context
        let predicate = FetchDescriptor(predicate: #Predicate<HiddenLineMode> { $0.hidden })
        let hiddenLineModes = (try? context.fetch(predicate)) ?? []
        
        return hiddenLineModes.compactMap { $0.lineModeName }
    }
}
