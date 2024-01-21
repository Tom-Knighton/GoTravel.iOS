//
//  PlatformArrivals+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 19/01/2024.
//

import SwiftUI
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
            return Strings.StopPage.Platform.toString() + " " + self.platformName
        }
    }
    
    /// Returns a friendly 'towards' string based on the arrivals here
    func friendlyTowards() -> String? {
        let towards = self.arrivalDepartures.compactMap { $0.destinationName }
        
        if towards.count > 0 {
            if towards.count == 2 {
                return String(Set(towards).joined(separator: Strings.Misc.And.toString()))
            } else if towards.count > 2 {
                let distinct = Array(Set(towards))
                let last = distinct.last
                return String(distinct.dropLast().joined(separator: ", ")) + (last != nil ? Strings.Misc.OxfordComma.toString() + (last ?? "...") : "")
            } else {
                return towards.first
            }
        }
        
        return nil
    }
    
    func firstArrivalString() -> String? {
        if let arrival = self.arrivalDepartures.first, let date = arrival.bestDate() {
            let friendly = friendlyDueString(date)
            if friendly != Strings.StopPage.Due.toString() {
                return friendly + " " + Strings.StopPage.Mins.toString()
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
        
        for arrival in upcomingArrivals.sorted(by: { ($0.bestDate() ?? Date()) < ($1.bestDate() ?? Date())}) {
            if let date = arrival.bestDate() {
                arrivalStrings.append(friendlyDueString(date))
            }
        }
        
        var result = Strings.Misc.ThenLower.toString() + " " + arrivalStrings.joined(separator: ", ")
        if arrivalStrings.last != Strings.StopPage.Due.toString() {
            return result + " " + Strings.StopPage.Mins.toString()
        }
        
        return result
    }

    
    public func friendlyDueString(_ date: Date) -> String {
        let mins = Date().timeUntil(date, unit: .minutes)
        if mins <= 1.1 {
            return Strings.StopPage.Due.toString()
        }
        
        return String(describing: Int(mins.rounded()))
    }
}

extension ArrivalDeparture {
    
    func bestDate() -> Date? {
        return self.predictedDeparture ?? self.scheduledDeparture ?? self.predictedArrival ?? self.scheduledArrival
    }
}
