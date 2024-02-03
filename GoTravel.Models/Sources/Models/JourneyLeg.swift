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
    
    /// If starting at a StopPoint, the id of the stop this leg starts at
    public let startAtStopId: String?
    
    /// If ending at a StopPoint, the id of the stop this leg ends at
    public let endAtStopId: String?
    
    /// If starting at a StopPoint, the friendly name of the stop this leg starts at
    public let startAtStopName: String?
    
    
    /// If ending at a StopPoint, the friendly name of the stop this leg ends at
    public let endAtStopName: String?
    
    
    /// The details of this leg. Includes information on the line mode, any specific instructions and steps
    public let legDetails: JourneyLegDetails
    
    public init(beginLegAt: Date, endLegAt: Date, legDuration: Int, startAtStopId: String?, endAtStopId: String?, startAtStopName: String?, endAtStopName: String?, legDetails: JourneyLegDetails) {
        self.beginLegAt = beginLegAt
        self.endLegAt = endLegAt
        self.legDuration = legDuration
        self.startAtStopId = startAtStopId
        self.endAtStopId = endAtStopId
        self.startAtStopName = startAtStopName
        self.endAtStopName = endAtStopName
        self.legDetails = legDetails
    }
}
