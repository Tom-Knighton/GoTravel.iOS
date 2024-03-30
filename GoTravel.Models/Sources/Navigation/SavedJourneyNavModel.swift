//
//  SavedJourneyNavModel.swift
//
//
//  Created by Tom Knighton on 21/03/2024.
//

import Foundation

public struct SavedJourneyNavModel: Hashable {
    public static func == (lhs: SavedJourneyNavModel, rhs: SavedJourneyNavModel) -> Bool {
        lhs.journey.journeyId == rhs.journey.journeyId
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(journey.journeyId)
    }
    
    public let journey: UserSavedJourney
    
    public init(journey: UserSavedJourney) {
        self.journey = journey
    }
}
