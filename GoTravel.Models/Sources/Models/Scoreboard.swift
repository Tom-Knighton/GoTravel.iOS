//
//  Scoreboard.swift
//
//
//  Created by Tom Knighton on 31/03/2024.
//

import Foundation
import DefaultCodable

public struct Scoreboard: Codable {
    
    public let scoreboardId: String
    public let scoreboardName: String
    public let scoreboardDescription: String
    public let scoreboardLogoUrl: String?
    public let startDate: Date
    public let endDate: Date?
    public let doesReset: Bool
    
    @Default<Empty>
    public var scoreboardUsers: [ScoreboardUser]
    
    public init(scoreboardId: String, scoreboardName: String, scoreboardDescription: String, scoreboardLogoUrl: String?, startDate: Date, endDate: Date?, doesReset: Bool, scoreboardUsers: [ScoreboardUser]) {
        self.scoreboardId = scoreboardId
        self.scoreboardName = scoreboardName
        self.scoreboardDescription = scoreboardDescription
        self.scoreboardLogoUrl = scoreboardLogoUrl
        self.startDate = startDate
        self.endDate = endDate
        self.doesReset = doesReset
        self.scoreboardUsers = scoreboardUsers
    }
}
