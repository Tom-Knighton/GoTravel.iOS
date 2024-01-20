//
//  PlatformArrivals+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 19/01/2024.
//

import Foundation
import GoTravel_Models

extension StopPointPlatformArrivals {
    
    /// Returns a friendly direction for the platform group, if possible
    func friendlyDirection() -> String? {
        let parts = self.platformName.split(separator: "-")
        
        var platform: String? = nil
        
        if parts.count == 2 {
            let directionPart = parts.first(where: { !$0.trimmingCharacters(in: .whitespacesAndNewlines).starts(with: "Platform" )})
            if let directionPart {
                platform = String(directionPart).trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } else {
            //TODO: log
            print("ERROR: Invalid platform name components? \(platformName)")
        }
        
        return platform
    }
    
    /// Returns either the friendly platform name or just the entire original name from API if unable to determine
    func friendlyPlatformName() -> String {
        let parts = self.platformName.split(separator: "-")
        let platformPart = parts.first(where: { $0.trimmingCharacters(in: .whitespacesAndNewlines).contains("Platform" )})

        if let platformPart {
            return String(platformPart).trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            return "Platform " + self.platformName
        }
    }
    
    func firstArrivalString() -> String? {
        if let arrival = self.arrivalDepartures.first, let date = arrival.bestDate() {
            let friendly = friendlyDueString(date)
            if friendly != "Due" {
                return friendly + " mins"
            }
            return friendly
        }
        
        return nil
    }
    
    func nextArrivalsString() -> String? {
        let upcomingArrivals = self.arrivalDepartures.dropFirst().prefix(3).filter { $0.bestDate() != nil }
        guard upcomingArrivals.count > 0 else {
            return nil
        }
        
        var arrivalStrings: [String] = []
        
        for arrival in upcomingArrivals {
            if let date = arrival.bestDate() {
                arrivalStrings.append(friendlyDueString(date))
            }
        }
        
        var result = "then " + arrivalStrings.joined(separator: ", ")
        if arrivalStrings.last != "Due" {
            result += " mins"
        }
        
        return result
    }

    
    public func friendlyDueString(_ date: Date) -> String {
        let mins = Date().timeUntil(date, unit: .minutes)
        if mins <= 1.1 {
            return "Due"
        }
        
        return String(describing: Int(mins.rounded()))
    }
}

extension ArrivalDeparture {
    
    func bestDate() -> Date? {
        return self.predictedDeparture ?? self.scheduledDeparture ?? self.predictedArrival ?? self.scheduledArrival
    }
}
