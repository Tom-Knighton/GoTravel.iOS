//
//  StopPointLineArrivals.swift
//
//
//  Created by Tom Knighton on 18/01/2024.
//

import Foundation

/// Represents the arrivals/departures for a specific line
public struct StopPointLineArrivals: Decodable {

    /// The line mode this line operates under
    public let lineMode: String
    
    /// the Id of the line the arrivals/departures are for
    public let lineId: String
    
    /// The friendly name of the line, this is not populated by the API
    public let lineName: String?
    
    /// The arrivals split into their respective platforms
    public var platforms: [StopPointPlatformArrivals]
    
    public init(lineMode: String, lineId: String, lineName: String, platforms: [StopPointPlatformArrivals]) {
        self.lineMode = lineMode
        self.lineId = lineId
        self.platforms = platforms
        self.lineName = lineName
    }
}
