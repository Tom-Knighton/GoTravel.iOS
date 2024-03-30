//
//  CurrentTracking.swift
//  
//
//  Created by Tom Knighton on 19/03/2024.
//

import Foundation
import SwiftData
import CoreLocation

@Model
public class CurrentTrackingData {
    
    public let startedAt: Date
    
    public var coordinates: [TrackingLocation]
    
    public init(startedAt: Date, coordinates: [TrackingLocation]) {
        self.startedAt = startedAt
        self.coordinates = coordinates
    }
}

@Model
public class TrackingLocation {
    
    public let time: Date
    public let latitude: Double
    public let longitude: Double
    public let speed: Double
    public let direction: Double
    
    public init(time: Date, latitude: Double, longitude: Double, speed: Double, direction: Double) {
        self.time = time
        self.latitude = latitude
        self.longitude = longitude
        self.speed = speed
        self.direction = direction
    }
    
    public init(_ loc: CLLocation) {
        self.time = loc.timestamp
        self.latitude = loc.coordinate.latitude
        self.longitude = loc.coordinate.longitude
        self.speed = loc.speed
        self.direction = loc.course
    }
    
}
