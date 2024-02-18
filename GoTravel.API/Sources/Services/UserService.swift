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
    
    /// Updates details for a specified user
    public static func UpdateDetails(for username: String, to details: UpdateUserDetails) async throws -> Bool {
        
        let request = APIRequest(method: .put, path: "User/\(username)/updateDetails", queryItems: [], body: details.toJson())
        let result: Bool = try await client.perform(request)
        
        return result
    }
    
    /// Updates user profile pic url for a specified user
    /// imageData should come from uiImage.jpegData
    public static func UpdateProfilePic(for username: String, to imageData: Data) async throws -> Bool {
        
        let boundary = "Boundary-\(UUID().uuidString)"

        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8) ?? Data())
        body.append("Content-Disposition: form-data; name=\"picture\"; filename=\"image.jpg\"\r\n".data(using: .utf8) ?? Data())
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) ?? Data())
        body.append(imageData)
        body.append("\r\n".data(using: .utf8) ?? Data())
        body.append("--\(boundary)--\r\n".data(using: .utf8) ?? Data())
        
        let request = APIRequest(method: .put, path: "User/\(username)/updateProfilePicture", queryItems: [], body: body, contentType: "multipart/form-data; boundary=\(boundary)")
        let result: Bool = try await client.perform(request)
        
        return result
    }
}
