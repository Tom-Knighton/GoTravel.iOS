//
//  FriendshipsService.swift
//
//
//  Created by Tom Knighton on 02/03/2024.
//

import Foundation
import GoTravel_Models

public struct FriendshipsService {
    
    private static let api = APIClient()
    
    public static func updateFriendship(followingId: String, to following: Bool) async throws -> Bool {
        
        let body = UpdateFriendshipCommand(followingId: followingId, following: following)
        let request = APIRequest(method: .put, path: "UserFriendships/Update", queryItems: [], body: body.toJson())
        try await api.performExpect200(request)
        
        return true
    }
    
    public static func respondToRequest(requesterId: String, accept: Bool) async throws -> Bool {
        let body = RespondToFriendshipCommand(userId: requesterId, approve: accept)
        let request = APIRequest(method: .post, path: "UserFriendships/Respond", queryItems: [], body: body.toJson())
        try await api.performExpect200(request)
        
        return true
    }
    
    public static func removeFollower(followerId: String) async throws -> Bool {
        let request = APIRequest(method: .delete, path: "UserFriendships/RemoveFollower", queryItems: [.init(name: "followerId", value: followerId)], body: nil)
        try await api.performExpect200(request)
        
        return true
    }
}
