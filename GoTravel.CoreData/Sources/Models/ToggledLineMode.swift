//
//  ToggledLineMode.swift
//
//
//  Created by Tom Knighton on 07/12/2023.
//

import Foundation
import SwiftData

@Model
public final class HiddenLineMode {
    
    public let lineModeName: String
    public let hidden: Bool
    
    public init(lineModeName: String, hidden: Bool) {
        self.lineModeName = lineModeName
        self.hidden = hidden
    }
}
