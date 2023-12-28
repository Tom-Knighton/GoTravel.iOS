//
//  LineMode+Cache.swift
//  GoTravel
//
//  Created by Tom Knighton on 06/12/2023.
//

import Foundation
import GoTravel_Models
import GoTravel_CoreData

extension LineMode {
    
    public init(cache: LineModeCache) {
        self.init(lineModeName: cache.lineMode, lines: [], primaryAreaName: cache.primaryAreaName, branding: .init(cache: cache.branding), flags: cache.flags)
    }
}

extension LineModeBranding {
    
    public init(cache: LineModeBrandingCache) {
        self.init(lineModeLogoUrl: cache.lineModeLogoUrl, lineModeBackgroundColour: cache.lineModeBackgroundColour, lineModePrimaryColour: cache.lineModePrimaryColour, lineModeSecondaryColour: cache.lineModeSecondaryColour)
    }
}
