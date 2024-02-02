//
//  Journey.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation

/// Represents a journey that can be taken
public struct Journey {
    
    /// The time the journey starts
    public let beginJourneyAt: Date
    
    /// The time the journey ends
    public let endJourneyAt: Date
    
    /// The total duration, in minutes, the journey is estimated to take
    public let totalDuration: Int
    
    /// The ordered series of legs the journey has, i.e. walk to stop X, take mode Y to stop Z etc.
    public let journeyLegs: [JourneyLeg]
    
    public init(beginJourneyAt: Date, endJourneyAt: Date, totalDuration: Int, journeyLegs: [JourneyLeg]) {
        self.beginJourneyAt = beginJourneyAt
        self.endJourneyAt = endJourneyAt
        self.totalDuration = totalDuration
        self.journeyLegs = journeyLegs
    }
}
