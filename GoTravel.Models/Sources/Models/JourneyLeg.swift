//
//  JourneyLeg.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation

/// Represents a 'step' of a journey, i.e. travelling from one place to another by a specified mode
public struct JourneyLeg: Codable {
    
    /// The time this leg begins
    public let beginLegAt: Date
    
    /// The time this leg ends at
    public let endLegAt: Date
    
    /// The total duration, in minutes, of this leg of the journey
    public let legDuration: Int
    
    
    /// The friendly name of the stop this leg starts at
    public let startAtName: String?
    
    /// The friendly name of the stop this leg ends at
    public let endAtName: String?
    
    /// The details of this leg. Includes information on the line mode, any specific instructions and steps
    public let legDetails: JourneyLegDetails
    
    /// If the leg starts at a stop point, this is the name and id of that point
    public let startAtStop: JourneyStopPoint?
    
    /// If the leg ends at a stop point, this is the name and id of that point
    public let endAtStop: JourneyStopPoint?
    
    public init(beginLegAt: Date, endLegAt: Date, legDuration: Int, startAtStop: JourneyStopPoint?, endAtStop: JourneyStopPoint?, startAtName: String?, endAtName: String?, legDetails: JourneyLegDetails) {
        self.beginLegAt = beginLegAt
        self.endLegAt = endLegAt
        self.legDuration = legDuration
        self.startAtStop = startAtStop
        self.endAtStop = endAtStop
        self.startAtName = startAtName
        self.endAtName = endAtName
        self.legDetails = legDetails
    }
}
