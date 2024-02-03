//
//  JourneyRequestPreferenceMode.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation

/// A preference for planning a journey
public enum JourneyRequestPreferenceMode: String, Codable {
    
    /// Prioritise the least amount of changes for a journey, even if it increases journey length
    case leastChanges = "LeastChanges"
    
    /// Prioritise the least total journey time
    case leastTime = "LeastTime"
    
    /// Prioritise the least amount of walking, even if it increases journey length
    case leastWalking = "LeastWalking"
}
