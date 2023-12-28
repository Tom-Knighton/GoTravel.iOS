//
//  LineMode+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import SwiftUI
import GoTravel_Models

extension LineMode {
    
    /// Whether or not the line mode contains the specified flag
    /// - Parameter flagName: The name/key of the flag
    func hasFlag(_ flagName: String) -> Bool {
        self.flags.contains(where: { $0 == flagName })
    }
    
    //TODO: Work out how to deal with n.... amount of line modes we don't know about
    var lineModeImportance: Int {
        switch self.lineModeName {
        case "Bus":
            return 0
        case "DLR":
            return 1
        case "National Rail":
            return 2
        case "Tram":
            return 2
        case "London Overground":
            return 3
        case "Cable Car":
            return 3
        case "Tube":
            return 4
        case "Elizabeth Line":
            return 5

        default:
            return -1
        }
    }
}
