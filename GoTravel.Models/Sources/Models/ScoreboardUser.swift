//
//  ScoreboardUser.swift
//
//
//  Created by Tom Knighton on 31/03/2024.
//

import Foundation

public struct ScoreboardUser: Codable, Equatable {
    
    public let rank: Int
    public let points: Int
    public let user: User
    
    public init(rank: Int, points: Int, user: User) {
        self.rank = rank
        self.points = points
        self.user = user
    }
}
