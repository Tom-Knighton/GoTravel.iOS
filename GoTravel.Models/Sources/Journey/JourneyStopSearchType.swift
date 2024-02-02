//
//  JourneyStopSearchType.swift
//
//
//  Created by Tom Knighton on 30/01/2024.
//

import Foundation

public enum JourneyStopSearchType: Int, Identifiable {
    case from = 0
    case to = 1
    case via = 2
    
    public var id: Self {
        return self
    }
}
