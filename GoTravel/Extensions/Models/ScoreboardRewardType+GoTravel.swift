//
//  ScoreboardRewardType+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 02/04/2024.
//

import SwiftUI
import GoTravel_Models

extension ScoreboardRewardType {
    
    public func getFriendlyName() -> LocalizedStringKey {
        switch self {
        case .noReward:
            return Strings.Community.Rewards.None
        case .pointMultiplier1_5:
            return Strings.Community.Rewards.Mult1_5
        case .pointMultiplier2:
            return Strings.Community.Rewards.Mult_2
        case .startingPoints_30:
            return Strings.Community.Rewards.Points30
        case .startingPoints_10:
            return Strings.Community.Rewards.Points10
        case .titleSuperTraveller:
            return Strings.Community.Rewards.TitleSuper
        case .titlePublicExpert:
            return Strings.Community.Rewards.TitleExpert
        }
    }
}
