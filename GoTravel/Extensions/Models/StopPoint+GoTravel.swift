//
//  StopPoint+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation
import GoTravel_Models

extension StopPointBase {
    
    /// Returns the 'most important' or main line mode of this Stop Point
    var mostImportantLineMode: LineMode? {
        guard !lineModes.isEmpty else {
            return nil
        }
        
        let modes = lineModes.sorted { $0.lineModeImportance > $1.lineModeImportance }
        return modes.first
    }
}
