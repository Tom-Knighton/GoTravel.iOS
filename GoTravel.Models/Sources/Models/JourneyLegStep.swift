//
//  JourneyLegStep.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation

/// A specific step/instruction in a journey leg
public struct JourneyLegStep {
    
    /// A summary of this step i.e. 'Continue along...'
    public let summary: String
    
    /// A direction may be present along this step, i.e. 'NorthWest'
    public let direction: String?
    
    /// The decimal latitude this step 'starts' or is at
    public let latitude: Double
    
    /// The decimal longitude of this step 'starts' or is at
    public let longitude: Double
    
    /// The distance, in metres, this step is 'for'
    public let distanceOfStep: Int
    
    public init(summary: String, direction: String?, latitude: Double, longitude: Double, distanceOfStep: Int) {
        self.summary = summary
        self.direction = direction
        self.latitude = latitude
        self.longitude = longitude
        self.distanceOfStep = distanceOfStep
    }
}
