//
//  Color+GoLondon.swift
//  GoLondon
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
}

