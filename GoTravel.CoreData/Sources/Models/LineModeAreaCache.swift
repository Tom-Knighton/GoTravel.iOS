//
//  LineModeAreaCache.swift
//
//
//  Created by Tom Knighton on 05/12/2023.
//

import Foundation
import SwiftData

@Model
public final class LineModeAreaCache {
    
    public let areaName: String
    public let lineModes: [LineModeCache]
    public let cacheTime: Date
    
    public init(areaName: String, lineModes: [LineModeCache]) {
        self.areaName = areaName
        self.lineModes = lineModes
        self.cacheTime = Date()
    }
}
