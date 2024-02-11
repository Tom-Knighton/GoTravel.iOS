//
//  AuthClient.swift
//
//
//  Created by Tom Knighton on 10/02/2024.
//

import Foundation
import GoTravel_Models
import Auth0

public actor AuthClient {
    
    private static let auth = Auth0.authentication(clientId: "1QQ5VqEGFtqJxA6MtdL2owDz2tDioCfz", domain: (Bundle.main.object(forInfoDictionaryKey: "AUTH0_BASE_URL") as? String ?? ""))
    private static let scopes = "openid profile offline_access"
    
    public static func Authenticate(with appleCode: String) async throws -> Bool {
        let token = try await auth
            .login(appleAuthorizationCode: appleCode, audience: "https://go-travel-dev", scope: scopes)
            .start()
        
        let didStore = CredentialsManager(authentication: auth).store(credentials: token)
        return didStore
    }
    
    public static func Authenticate(with username: String, password: String) async throws -> Bool {
        let token = try await auth
            .loginDefaultDirectory(withUsername: username, password: password, audience: "https://go-travel-dev", scope: scopes)
            .start()
        
        let didStore = CredentialsManager(authentication: auth).store(credentials: token)
        return didStore
    }
    
    public static func SignUp(with email: String, password: String, username: String) async throws -> Bool {
        let token = try await auth
            .signup(email: email, username: username, password: password, connection: "Username-Password-Authentication")
            .start()
        
        return try await Authenticate(with: email, password: password)
    }
    
    public init() {
        
    }
    
}
