//
//  SavedJourney.swift
//
//
//  Created by Tom Knighton on 20/03/2024.
//

import SwiftUI
import SwiftData

@Model
public class SavedJourney {

    public let name: String?
    public let startedAt: Date
    public let endedAt: Date
    
    public let coordinates: [TrackingLocation]
    
    public let lines: [String]
    
    public init(name: String?, startedAt: Date, endedAt: Date, coordinates: [TrackingLocation], lines: [String]) {
        self.name = name
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.coordinates = coordinates
        self.lines = lines
    }
}
