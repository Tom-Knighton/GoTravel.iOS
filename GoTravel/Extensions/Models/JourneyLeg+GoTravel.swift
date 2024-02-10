//
//  JourneyLeg+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 09/02/2024.
//

import Foundation
import GoTravel_Models

extension JourneyLeg: Identifiable, Hashable {
    public static func == (lhs: GoTravel_Models.JourneyLeg, rhs: GoTravel_Models.JourneyLeg) -> Bool {
        lhs.beginLegAt == rhs.beginLegAt && lhs.legDetails.lineMode.lineModeId == rhs.legDetails.lineMode.lineModeId
    }
    
    public var id: Int {
        self.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.beginLegAt)
        hasher.combine(self.endLegAt)
        hasher.combine(self.legDetails.lineMode.lineModeId)
        hasher.combine(self.legDetails.lineMode.lines.compactMap { $0.lineId })
    }
}
