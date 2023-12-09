//
//  LineModeBranding.swift
//
//
//  Created by Tom Knighton on 05/12/2023.
//

import Foundation

/// Branding information for a specific line mode
public struct LineModeBranding: Codable {
    
    /// The url to an image of the line mode's logo
    public let lineModeLogoUrl: String
    
    /// The 'background' colour to use opposite a background colour
    public let lineModeBackgroundColour: String
    
    /// The primary colour of the line mode, i.e. purple for Elizabeth Line
    public let lineModePrimaryColour: String
    
    /// The optional secondary colour of a line mode, i.e. red for tube
    public let lineModeSecondaryColour: String?
    
    public init(lineModeLogoUrl: String, lineModeBackgroundColour: String, lineModePrimaryColour: String, lineModeSecondaryColour: String?) {
        self.lineModeLogoUrl = lineModeLogoUrl
        self.lineModeBackgroundColour = lineModeBackgroundColour
        self.lineModePrimaryColour = lineModePrimaryColour
        self.lineModeSecondaryColour = lineModeSecondaryColour
    }
}
