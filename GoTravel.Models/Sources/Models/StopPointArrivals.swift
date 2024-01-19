//
//  StopPointArrivals.swift
//
//
//  Created by Tom Knighton on 18/01/2024.
//

import Foundation

/// Represents arrivals for a specific stop point
public struct StopPointArrivals: Decodable {
    
    /// The id of the stop these arrivals are for
    public let stopPointId: String
    
    /// The arrivals/departures for each mode with arrival/departure data
    public let modeArrivals: [StopPointModeArrivals]
    
    public init(stopPointId: String, modeArrivals: [StopPointModeArrivals]) {
        self.stopPointId = stopPointId
        self.modeArrivals = modeArrivals
    }
    
}
