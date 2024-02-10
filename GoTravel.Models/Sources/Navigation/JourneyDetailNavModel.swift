//
//  JourneyDetailNavModel.swift
//
//
//  Created by Tom Knighton on 09/02/2024.
//

import Foundation

public struct JourneyDetailNavModel: Hashable {
    public static func == (lhs: JourneyDetailNavModel, rhs: JourneyDetailNavModel) -> Bool {
        lhs.journey.journeyLegs.count == rhs.journey.journeyLegs.count && lhs.journey.beginJourneyAt == rhs.journey.beginJourneyAt
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(journey.beginJourneyAt)
        hasher.combine(journey.endJourneyAt)
        hasher.combine(journey.journeyLegs.compactMap { $0.legDetails.lineMode.lineModeId })
    }
    
    
    public let journey: Journey
    
    public init(journey: Journey) {
        self.journey = journey
    }
}
