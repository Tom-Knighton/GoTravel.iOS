//
//  UserSavedJourney.swift
//
//
//  Created by Tom Knighton on 27/03/2024.
//

import Foundation
import DefaultCodable

public struct UserSavedJourney: Codable {
    
    public let journeyId: String
    
    public var journeyName: String
    
    public let startedAt: Date
    public let endedAt: Date
    
    public let pointsReceived: Int
    public let isUnderReview: Bool
    public let note: String?
    
    @Default<Empty>
    public var coordinates: [[Double]]
    
    @Default<Empty>
    public var lines: [Line]
    
    public init(journeyId: String, journeyName: String, startedAt: Date, endedAt: Date, pointsReceived: Int, isUnderReview: Bool, note: String?, coordinates: [[Double]], lines: [Line]) {
        self.journeyId = journeyId
        self.journeyName = journeyName
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.pointsReceived = pointsReceived
        self.isUnderReview = isUnderReview
        self.note = note
        self.coordinates = coordinates
        self.lines = lines
    }
}
