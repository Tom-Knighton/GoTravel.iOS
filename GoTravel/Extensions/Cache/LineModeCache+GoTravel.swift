//
//  LineModeCache+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 06/12/2023.
//

import Foundation
import GoTravel_Models
import GoTravel_CoreData

extension LineModeAreaCache {
    
    convenience init(lineModeGroup: LineModeGroup) {
        self.init(areaName: lineModeGroup.areaName, lineModes: lineModeGroup.lineModes.compactMap { LineModeCache(lineMode: $0) })
    }
    
    public func toLineModeGroup() -> LineModeGroup {
        LineModeGroup(cache: self)
    }
}

extension LineModeCache {
    
    convenience init(lineMode: LineMode) {
        self.init(lineMode: lineMode.lineModeName, primaryAreaName: lineMode.primaryAreaName, branding: .init(branding: lineMode.branding))
    }
}

extension LineModeBrandingCache {
    
    convenience init(branding: LineModeBranding) {
        self.init(lineModeLogoUrl: branding.lineModeLogoUrl, lineModeBackgroundColour: branding.lineModeBackgroundColour, lineModePrimaryColour: branding.lineModePrimaryColour, lineModeSecondaryColour: branding.lineModeSecondaryColour)
    }
}
