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
        let current = Date().timeIntervalSinceReferenceDate / unit.rawValue
        
        return Double(timeUntil - current)
    }
    
    public func friendlyDifference(_ to : Date) -> String {
        let interval = self.timeIntervalSince(to)
        
        let hours = Int(interval) / 3600
        let minutes = Int(interval) / 60 % 60
        let seconds = Int(interval) % 60

        var result = ""
        if hours != 0 {
            result += "\(hours)hr\(hours > 1 ? "s" : "") "
        }
        if minutes != 0{
            result += "\(minutes)min\(minutes > 1 ? "s" : "") "
        }
        if seconds != 0 {
            result += "\(seconds)sec\(seconds > 1 ? "s" : "")"
        }
        
        return result.trimmingCharacters(in: .whitespaces)
    }
}
