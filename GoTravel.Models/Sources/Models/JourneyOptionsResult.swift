//
//  JourneyOptionsResult.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation

/// Represents a series of journey options for a requested journey, and the line modes used in those journeys
public struct JourneyOptionsResult: Codable {
        
    /// The possible journey options that can be taken
    public let journeyOptions: [Journey]
    
    public init(journeyOptions: [Journey]) {
        self.journeyOptions = journeyOptions
    }
}
