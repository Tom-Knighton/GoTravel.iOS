//
//  JourneyLegDetails.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation

/// Details about a specific leg of a journey option
public struct JourneyLegDetails {
    
    /// The summary of the leg, i.e. 'Bus to Stop X'
    public let summary: String
    
    /// A more detailed summary of the leg may be present in some legs, i.e. 'Line X *towards* Y'. It may also be the same as `summary`
    public let detailedSummary: String?
    
    /// The id of the line mode this leg uses
    public let modeId: String
    
    /// The different ids of lines that could be taken. This could be none, if walking for instance, or more than one in the case of i.e. buses where multiple lines go along the same route part
    public let lineIds: [String]
    
    /// Some specific steps for this leg, usually present in more manual modes like walking or cycling
    public let legSteps: [JourneyLegStep]
    
    public init(summary: String, detailedSummary: String, modeId: String, lineIds: [String], legSteps: [JourneyLegStep]) {
        self.summary = summary
        self.detailedSummary = detailedSummary
        self.modeId = modeId
        self.lineIds = lineIds
        self.legSteps = legSteps
    }
}
