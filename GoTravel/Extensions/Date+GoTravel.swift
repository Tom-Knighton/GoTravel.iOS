//
//  Date+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 18/01/2024.
//

import Foundation

public enum TimeUntiUnit: Double {
    case minutes = 60
    case seconds = 1
    case hours = 3600
}

extension Date {
    
    public func timeUntil(_ until: Date, unit: TimeUntiUnit = .seconds)  -> Double {
        
        
        
        let timeUntil = until.timeIntervalSinceReferenceDate / unit.rawValue
        let current = until.timeIntervalSinceReferenceDate / unit.rawValue
        
        return Double(timeUntil - current)
    }
}
