//
//  LineModeBrandingCache.swift
//
//
//  Created by Tom Knighton on 05/12/2023.
//

import Foundation
import SwiftData

@Model
public final class LineModeBrandingCache {
    public let lineModeLogoUrl: String
    public let lineModeBackgroundColour: String
    public let lineModePrimaryColour: String
    public let lineModeSecondaryColour: String?
    
    public init(lineModeLogoUrl: String, lineModeBackgroundColour: String, lineModePrimaryColour: String, lineModeSecondaryColour: String?) {
        self.lineModeLogoUrl = lineModeLogoUrl
        self.lineModeBackgroundColour = lineModeBackgroundColour
        self.lineModePrimaryColour = lineModePrimaryColour
        self.lineModeSecondaryColour = lineModeSecondaryColour
    }
}
