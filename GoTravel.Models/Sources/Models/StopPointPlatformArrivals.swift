//
//  StopPointPlatformArrivals.swift
//
//
//  Created by Tom Knighton on 18/01/2024.
//

import Foundation

/// Represents arrivals/departures at a specific platform, for a specific line
public struct StopPointPlatformArrivals: Decodable {
    
    public let platformName: String
    public let direction: String?
    public let arrivalDepartures: [ArrivalDeparture]
    
    public init(platformName: String, direction: String, arrivalDepartures: [ArrivalDeparture]) {
        self.platformName = platformName
        self.direction = direction
        self.arrivalDepartures = arrivalDepartures
    }
    
}
