//
//  StopPointNavModel.swift
//
//
//  Created by Tom Knighton on 16/01/2024.
//

import Foundation

public struct StopPointNavModel: Hashable {
    
    public let stopPointId: String
    
    public init(stopPointId: String) {
        self.stopPointId = stopPointId
    }
}
