//
//  User.swift
//
//
//  Created by Tom Knighton on 12/02/2024.
//

import Foundation

/// Information on a generic user
public struct User: Decodable {
    
    /// The unique user name of the user
    public let userName: String
    
    /// A url to the user's profile picture
    public let userPictureUrl: String
}
