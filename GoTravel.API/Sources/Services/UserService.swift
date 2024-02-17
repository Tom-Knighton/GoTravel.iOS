//
//  UserService.swift
//
//
//  Created by Tom Knighton on 12/02/2024.
//

import Foundation
import GoTravel_Models

/// Methods to retrieve information on/update users
public struct UserService {
    
    public static let client = APIClient()
    
    /// Returns the current user information
    public static func CurrentUser() async throws -> CurrentUser {
        
        let request = APIRequest(path: "User/me", queryItems: [], body: nil)
        let result: CurrentUser = try await client.perform(request)
        
        return result
    }
    
    /// Returns information on a specified user
    public static func UserByUsername(_ username: String) async throws -> User {
        
        let request = APIRequest(path: "User/\(username)", queryItems: [], body: nil)
        let result: User = try await client.perform(request)
        
        return result
    }
    
}
