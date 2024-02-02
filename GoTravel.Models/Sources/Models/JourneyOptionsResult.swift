//
//  JourneyOptionsResult.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation

/// Represents a series of journey options for a requested journey, and the line modes used in those journeys
public struct JourneyOptionsResult {
    
    /// All the line modes and relevant lines from the possible journey options
    public let lineModes: [LineMode]
    
    /// The possible journey options that can be taken
    public let journeyOptions: [Journey]
    
    public init(lineModes: [LineMode], journeyOptions: [Journey]) {
        self.lineModes = lineModes
        self.journeyOptions = journeyOptions
    }
}
