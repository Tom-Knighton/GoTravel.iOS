//
//  Line.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation

public struct Line: Codable, Equatable {
    
    /// The unique id of the line
    public let lineId: String
    
    /// The friendly name of the line, i.e. Central Line
    public let lineName: String
    
    /// If present, the branding colour hex for this line, i.e. #ff0000
    public let linePrimaryColour: String?
    
    
    
    public init(lineId: String, lineName: String, linePrimaryColour: String?) {
        self.lineId = lineId
        self.lineName = lineName
        self.linePrimaryColour = linePrimaryColour
    }
}
