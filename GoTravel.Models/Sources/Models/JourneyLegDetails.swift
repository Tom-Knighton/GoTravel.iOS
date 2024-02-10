//
//  JourneyLegDetails.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation
import Turf

/// Details about a specific leg of a journey option
public struct JourneyLegDetails: Codable {
    
    /// The summary of the leg, i.e. 'Bus to Stop X'
    public let summary: String
    
    /// A more detailed summary of the leg may be present in some legs, i.e. 'Line X *towards* Y'. It may also be the same as `summary`
    public let detailedSummary: String?
    
    /// The line mode to use this leg. This may be a fake mode i.e. 'walking' or 'cycle', or the real mode with the relevant lines
    public let lineMode: LineMode
    
    /// A Turf.js line string of the route this leg will take
    public let lineString: LineString
    
    /// An array of the minimal stop point data this leg travels through if any
    public let stopPoints: [JourneyStopPoint]
    
    /// Some specific steps for this leg, usually present in more manual modes like walking or cycling
    public let legSteps: [JourneyLegStep]
    
    public init(summary: String, detailedSummary: String, lineMode: LineMode, lineString: LineString, stops: [JourneyStopPoint], legSteps: [JourneyLegStep]) {
        self.summary = summary
        self.detailedSummary = detailedSummary
        self.lineMode = lineMode
        self.lineString = lineString
        self.legSteps = legSteps
        self.stopPoints = stops
    }
}
