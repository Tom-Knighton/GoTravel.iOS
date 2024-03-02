//
//  RespondToFriendshipCommand.swift
//
//
//  Created by Tom Knighton on 02/03/2024.
//

import Foundation

public struct RespondToFriendshipCommand: Codable {
    
    public let userId: String
    public let approve: Bool
    
    public init(userId: String, approve: Bool) {
        self.userId = userId
        self.approve = approve
    }
}
