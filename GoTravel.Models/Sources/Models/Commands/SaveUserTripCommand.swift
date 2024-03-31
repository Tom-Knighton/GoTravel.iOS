//
//  SaveUserTripCommand.swift
//
//
//  Created by Tom Knighton on 27/03/2024.
//

import Foundation

public struct SaveUserTripCommand: Codable {
    
    public let startedAt: Date
    public let endedAt: Date
    public let averageSpeed: Double
    public let lines: [String]
    public let coordinates: [[Double]]
    public let name: String
    
    public init(name: String, startedAt: Date, endedAt: Date, averageSpeed: Double, lines: [String], coordinates: [[Double]]) {
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.averageSpeed = averageSpeed
        self.lines = lines
        self.coordinates = coordinates
        self.name = name
    }
}
