//
//  JourneyRequestLocation.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation
import CoreLocation

/// A location in a journey request
public struct JourneyRequestLocation: Codable {
    
    /// The decimal latitude of the point
    public let lat: Double
    
    /// The decimal longitude of the point
    public let lon: Double
    
    /// The coordinate representation of this location
    public func coordinate() -> CLLocationCoordinate2D {
        return .init(latitude: lat, longitude: lon)
    }
    
    public init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    public init(coordinate: CLLocationCoordinate2D) {
        self.lat = coordinate.latitude
        self.lon = coordinate.longitude
    }
}
