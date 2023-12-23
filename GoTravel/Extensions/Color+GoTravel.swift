//
//  Color+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import SwiftUI

extension Color {
    
    // Taken from https://stackoverflow.com/a/56894458/15873753
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    init?(hex: String, alpha: Double = 1) {
        var hexString = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        
        guard hex.count == 6 else {
            return nil
        }
        
        guard let hexValue = UInt(hex, radix: 16) else {
            return nil
        }
        
        self.init(hex: hexValue, alpha: alpha)
    }
}

