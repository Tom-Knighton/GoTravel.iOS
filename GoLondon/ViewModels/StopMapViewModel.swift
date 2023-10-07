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
    
    //MARK: Location Banner
    public var locationBannerClosed: Bool = false
    public var locationBannerOffser: Double = .zero
    
    public init() {
        self.mapPosition = MapCameraPosition.userLocation(fallback: .automatic)
        self.locationBannerClosed = false
    }
    
    public func searchAtUserLoc() async {
        if let loc = LocationManager.shared.manager.location {
            do {
                let result = try await StopPointService.SearchAround(lat: loc.coordinate.latitude, lon: loc.coordinate.longitude)
                print(result)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
