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
    
    public var stopPoints: [StopPoint] = []
    
    //MARK: Search
    public var searchDistance: Int = 1_000
    public var searchedLocation: CLLocation? = nil
    
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
                let result = try await StopPointService.SearchAround(lat: loc.coordinate.latitude, lon: loc.coordinate.longitude, radius: searchDistance)
                self.stopPoints = result
                self.searchedLocation = loc
            } catch let DecodingError.typeMismatch(type, context) {
                print(context.debugDescription)
                print(context.codingPath)
            } catch let DecodingError.keyNotFound(key, context) {
                print(context.debugDescription)
                print(context.codingPath)
                print(key)
            } catch let DecodingError.valueNotFound(val, context) {
                print(context.debugDescription)
                print(context.codingPath)
                print(val)
            } catch {
                print("caughy")
                print(error.localizedDescription)
            }
        }
    }
}
