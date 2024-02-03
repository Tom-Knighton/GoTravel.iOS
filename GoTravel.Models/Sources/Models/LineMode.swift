//
//  LineMode.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation

public struct LineMode: Codable {
    
    /// The unique id of the line
    public let lineModeId: String
    
    /// The friendly name of the line mode, i.e. Tube, Elizabeth Line
    public let lineModeName: String
    
    /// The lines that operate under this line mode
    public let lines: [Line]
    
    /// The primary area this line mode operates under, i.e. London, Manchester or UK
    public let primaryAreaName: String
    
    /// The branding of this line mode, mainly colour and logo information
    public let branding: LineModeBranding
    
    /// Flagged information for this line mode
    public let flags: [String]
    
    public init(lineModeId: String, lineModeName: String, lines: [Line], primaryAreaName: String, branding: LineModeBranding, flags: [String]) {
        self.lineModeId = lineModeId
        self.lineModeName = lineModeName
        self.lines = lines
        self.primaryAreaName = primaryAreaName
        self.branding = branding
        self.flags = flags
    }
}
