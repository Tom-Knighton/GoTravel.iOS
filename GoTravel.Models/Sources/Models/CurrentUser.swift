//
//  CurrentUser.swift
//
//
//  Created by Tom Knighton on 12/02/2024.
//

import Foundation
import DefaultCodable

/// Information on a current logged in user
public struct CurrentUser: Decodable {
    
    /// The unique id of the current user
    public let userId: String
    
    /// The unique username of the user
    public let userName: String
    
    /// The unique email the user signed up with
    public let userEmail: String
    
    /// A url to the user's profile picture
    public let userPictureUrl: String
    
    /// The date the user signed up
    public let dateCreated: Date
    
    /// DTOs of the users that follow this user
    @Default<Empty>
    public var followers: [User]
    
    /// DTOs of the users this user is following
    @Default<Empty>
    public var following: [User]
    
    public init(userId: String, userName: String, userEmail: String, userPictureUrl: String, dateCreated: Date, followers: [User] = [], following: [User] = []) {
        self.userId = userId
        self.userName = userName
        self.userEmail = userEmail
        self.userPictureUrl = userPictureUrl
        self.dateCreated = dateCreated
        self.followers = followers
        self.following = following
    }
}
