//
//  User.swift
//
//
//  Created by Tom Knighton on 12/02/2024.
//

import Foundation

/// Information on a generic user
public struct User: Codable, Equatable {
    
    /// The unique user name of the user
    public let userName: String
    
    /// A url to the user's profile picture
    public let userPictureUrl: String
    
    /// The number of users that follow this user
    public let followerCount: Int
    
    /// A subtitle a user may have through winning scoreboards
    public let subtitle: String?
    
    public init(userName: String, userPictureUrl: String, followerCount: Int, subtitle: String? = nil) {
        self.userName = userName
        self.userPictureUrl = userPictureUrl
        self.followerCount = followerCount
        self.subtitle = subtitle
    }
}
