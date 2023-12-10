//
//  LineModeCache+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 06/12/2023.
//

import Foundation
import GoTravel_Models
import GoTravel_CoreData

extension LineModeCache {
    
    convenience init(lineMode: LineMode) {
        self.init(lineMode: lineMode.lineModeName, primaryAreaName: lineMode.primaryAreaName, branding: .init(branding: lineMode.branding))
    }
    
    public func toLineMode() -> LineMode {
        LineMode(cache: self)
    }
}

extension LineModeBrandingCache {
    
    convenience init(branding: LineModeBranding) {
        self.init(lineModeLogoUrl: branding.lineModeLogoUrl, lineModeBackgroundColour: branding.lineModeBackgroundColour, lineModePrimaryColour: branding.lineModePrimaryColour, lineModeSecondaryColour: branding.lineModeSecondaryColour)
    }
}
