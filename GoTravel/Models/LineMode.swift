//
//  LineMode.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation

public struct LineMode: Codable {
    
    /// The friendly name of the line mode, i.e. Tube, Elizabeth Line
    public let lineModeName: String
    
    /// The lines that operate under this line mode
    public let lines: [Line]
}
