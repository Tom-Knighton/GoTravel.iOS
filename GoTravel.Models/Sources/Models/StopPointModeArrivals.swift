//
//  StopPointModeArrivals.swift
//
//
//  Created by Tom Knighton on 18/01/2024.
//

import Foundation

/// Represents arrivals/departures for a specifc line mode
public struct StopPointModeArrivals: Decodable {
    
    /// The Id of the line mode these arrivals/departures are for
    public let modeId: String
    
    /// The arrivals split into their respective line
    public let lineArrivals: [StopPointLineArrivals]
    
    public init(modeId: String, lineArrivals: [StopPointLineArrivals]) {
        self.modeId = modeId
        self.lineArrivals = lineArrivals
    }
}
