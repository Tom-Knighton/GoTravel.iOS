//
//  LineMode+GoLondon.swift
//  GoLondon
//
//  Created by Tom Knighton on 08/10/2023.
//

import SwiftUI

extension LineMode {
    
    /// The primary branding colour for this line mode
    var lineModeColour: Color {
        switch self.lineModeName {
        case "Elizabeth Line":
            return .init(hex: 0x6950A1)
        case "London Overground":
            return .init(hex: 0xEE7C0E)
        case "National Rail":
            return .red
        case "DLR":
            return .init(hex: 0x00A4A7)
        case "Bus":
            return .init(hex: 0xEE2E24)
        case "Tube":
            return .init(hex: 0x0009AB)
            
        
        default:
            return .red
        }
    }
    
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
