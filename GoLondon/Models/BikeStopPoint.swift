//
//  BikeStopPoint.swift
//  GoLondon
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation

/// A stop point where bikes are retrieved from/parked
public class BikeStopPoint: StopPointBase {
    
    /// The number of bikes free at this stop point
    public var bikesRemaining: Int = 0
    
    /// The number of electronic bikes free at this stop point
    public var eBikesRemaining: Int = 0
}
