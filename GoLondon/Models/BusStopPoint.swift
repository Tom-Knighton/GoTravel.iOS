//
//  BusStopPoint.swift
//  GoLondon
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation

/// Represents a stop point at which buses stop
public class BusStopPoint: StopPointBase {
     
    /// The 'letter' of the bus stop i.e. 'A', 'X', etc, may not be present
    public var busStopLetter: String?
    
    /// Usually some kind of indicator if the bus stop has no letter, i.e. '-> W' for a westbound stop
    public var busStopIndicator: String?
    
    /// The SMS code people can text to retrieve info for this bus stop
    public var busStopSMSCode: String?
}
