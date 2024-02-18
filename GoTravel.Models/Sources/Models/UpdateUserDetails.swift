//
//  UpdateUserDetails.swift
//
//
//  Created by Tom Knighton on 17/02/2024.
//

import Foundation

public struct UpdateUserDetails: Codable {
    
    public var username: String
    
    public init(username: String) {
        self.username = username
    }
}
