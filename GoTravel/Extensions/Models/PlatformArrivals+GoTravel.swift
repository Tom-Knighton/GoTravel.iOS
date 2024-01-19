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
            print("ERROR: Invalid platform name components?")
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
}
