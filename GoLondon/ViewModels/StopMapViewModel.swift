//
//  StopMapViewModel.swift
//  GoLondon
//
//  Created by Tom Knighton on 30/09/2023.
//

import SwiftUI
import Observation
import MapKit

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
    
    public func searchAtLocation(_ coordinate: CLLocationCoordinate2D) async {
        do {
            self.isSearching = true
            let result = try await StopPointService.SearchAround(lat: coordinate.latitude, lon: coordinate.longitude, radius: searchDistance)
            self.stopPoints = result
            self.searchedLocation = coordinate
            self.isSearching = false
        } catch {
            print("error decoding results")
            self.isSearching = false
        }
    }
}
