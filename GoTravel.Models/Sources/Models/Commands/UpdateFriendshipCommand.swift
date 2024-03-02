//
//  UpdateFriendshipCommand.swift
//
//
//  Created by Tom Knighton on 02/03/2024.
//

import Foundation

public struct UpdateFriendshipCommand: Codable {
    
    public let followingId: String
    public let follow: Bool
    
    public init(followingId: String, following: Bool) {
        self.followingId = followingId
        self.follow = following
    }
}
