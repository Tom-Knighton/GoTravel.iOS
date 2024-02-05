//
//  QuickJourneyNavModel.swift
//
//
//  Created by Tom Knighton on 05/02/2024.
//

import Foundation

public struct QuickJourneyNavModel: Hashable {
   
    
    public let destination: JourneyRequestPoint
    
    public static func == (lhs: QuickJourneyNavModel, rhs: QuickJourneyNavModel) -> Bool {
        lhs.destination.displayName == rhs.destination.displayName && lhs.destination.coordinate == rhs.destination.coordinate
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(destination.displayName)
        hasher.combine(destination.coordinate.latitude)
        hasher.combine(destination.coordinate.longitude)
    }
    
    public init(destination: JourneyRequestPoint) {
        self.destination = destination
    }
}
