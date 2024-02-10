//
//  JourneyStopPoint.swift
//
//
//  Created by Tom Knighton on 07/02/2024.
//

import Foundation
import Turf

public struct JourneyStopPoint: Codable {
    
    public let stopPointId: String
    public let stopPointName: String
    public let stopCoordinate: Point
    
    public init(stopPointId: String, stopPointName: String, coordinate: Point) {
        self.stopPointId = stopPointId
        self.stopPointName = stopPointName
        self.stopCoordinate = coordinate
    }
}
