//
//  UserData.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/03/2024.
//

import Foundation
import GoTravel_Models

#if DEBUG

public struct PreviewUserData {
    
    public static var User1: User = .init(userName: "Test 1", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)
    public static var User2: User = .init(userName: "Test 2", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 112)
    public static var User3: User = .init(userName: "Test 3", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 0)
    public static var User4: User = .init(userName: "Test 4", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)
    public static var User5: User = .init(userName: "Test 5", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)
    public static var User6: User = .init(userName: "Test 6", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)
    
    
    
    public static var Current: CurrentUser = CurrentUser(userId: "auth0|Id", userName: "tomknighton", userEmail: "tomknighton@icloud.com", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", dateCreated: Date(), followers: [.init(followingType: .following, user: User1), .init(followingType: .following, user: User2), .init(followingType: .following, user: User3)], following: [.init(followingType: .following, user: User1), .init(followingType: .following, user: User2), .init(followingType: .following, user: User3), .init(followingType: .following, user: User4)])
}

#endif
