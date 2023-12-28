//
//  File.swift
//  
//
//  Created by Tom Knighton on 05/12/2023.
//

import Foundation
import SwiftData

@Model
public final class LineModeCache {
    public let lineMode: String
    
    public let primaryAreaName: String
    public let branding: LineModeBrandingCache
    public let flags: [String]
    public let cacheTime: Date
    
    public init(lineMode: String, primaryAreaName: String, branding: LineModeBrandingCache, flags: [String]) {
        self.lineMode = lineMode
        self.primaryAreaName = primaryAreaName
        self.branding = branding
        self.flags = flags
        cacheTime = Date()
    }
    
}
