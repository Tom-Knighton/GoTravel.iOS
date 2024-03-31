//
//  ScoreboardService.swift
//
//
//  Created by Tom Knighton on 31/03/2024.
//

import Foundation
import GoTravel_Models

public struct ScoreboardService {
    
    static let client = APIClient()
    
    /// Returns a list of scoreboards the user is enrolled in, the top 10 users and the user's position
    public static func GetScoreboards(for userId: String) async throws -> [Scoreboard] {
        
        let request = APIRequest(path: "Scoreboard/User/\(userId)", queryItems: [], body: nil)
        let response: [Scoreboard] = try await client.perform(request)
        
        return response
    }
    
    /// Returns the scoreboard by it's id, if found
    public static func GetScoreboard(by id: String) async throws -> Scoreboard? {
        
        let request = APIRequest(path: "Scoreboard/\(id)", queryItems: [], body: nil)
        let response: Scoreboard? = try await client.perform(request)
        
        return response
    }
    
    /// Returns ordered users in a scoreboard, from the position specified
    public static func GetUsers(for scoreboardId: String, from position: Int = 1, maxResults: Int = 10) async throws -> [ScoreboardUser] {
        let request = APIRequest(path: "Scoreboard/\(scoreboardId)/Users", queryItems: [.init(name: "fromPosition", value: "\(position)"), .init(name: "results", value: "\(maxResults)")], body: nil)
        let response: [ScoreboardUser] = try await client.perform(request)
        
        return response
    }
}
