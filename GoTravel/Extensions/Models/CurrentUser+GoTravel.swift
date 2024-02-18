//
//  CurrentUser+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 18/02/2024.
//

import Foundation
import GoTravel_Models

extension CurrentUser: Equatable {
    public static func == (lhs: CurrentUser, rhs: CurrentUser) -> Bool {
        lhs.userId == rhs.userId
    }  
}
