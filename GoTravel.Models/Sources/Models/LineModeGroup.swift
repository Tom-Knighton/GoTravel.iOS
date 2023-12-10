//
//  LineModeGroup.swift
//
//
//  Created by Tom Knighton on 05/12/2023.
//

import Foundation

/// A group of line modes under an area
public struct LineModeGroup: Codable {
    
    /// The name of the area
    public var areaName: String
    
    /// The line modes under this area
    public let lineModes: [LineMode]
    
    public init(areaName: String, lineModes: [LineMode]) {
        self.areaName = areaName
        self.lineModes = lineModes
    }
}
