//
//  SavedJourneyNavModel.swift
//
//
//  Created by Tom Knighton on 21/03/2024.
//

import Foundation
import SwiftData

public struct SavedJourneyNavModel: Hashable {
    public let savedJourneyId: PersistentIdentifier
    
    public init(savedJourneyId: PersistentIdentifier) {
        self.savedJourneyId = savedJourneyId
    }
}
