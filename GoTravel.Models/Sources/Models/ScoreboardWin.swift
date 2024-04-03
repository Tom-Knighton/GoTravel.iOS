//
//  ScoreboardWin.swift
//
//
//  Created by Tom Knighton on 02/04/2024.
//

import Foundation
import SwiftUI

public struct ScoreboardWin: Codable, Identifiable {
    
    public let winId: String
    public let scoreboardName: String
    public let wonAt: Date
    public let position: Int
    public let rewardType: ScoreboardRewardType
    
    public var id: String { winId }
    
    public init(winId: String, scoreboardName: String, wonAt: Date, position: Int, rewardType: ScoreboardRewardType) {
        self.winId = winId
        self.scoreboardName = scoreboardName
        self.wonAt = wonAt
        self.position = position
        self.rewardType = rewardType
    }
}

public enum ScoreboardRewardType: String, Codable {
    
    case noReward = "None"
    case pointMultiplier1_5 = "PointMultiplier1_5"
    case pointMultiplier2 = "PointMultiplier_2"
    case startingPoints_30 = "StartingPoints_30"
    case startingPoints_10 = "StartingPoints_10"
    case titleSuperTraveller = "Title_SuperTraveller"
    case titlePublicExpert = "Title_PublicTransportExpert"
}
