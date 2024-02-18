//
//  SignInViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 11/02/2024.
//

import Foundation
import Observation
import AuthenticationServices
import GoTravel_API
import Auth0
import SwiftUI 

@Observable
public class SignInViewModel {
    
    public var userText: String = ""
    public var passwordText: String = ""
    public var isLoading: Bool = false
    public var somethingWentWrong: Bool = false
    
    public var error: LocalizedStringKey? = nil
    
    public func AppleAuthenticate(_ result: Result<ASAuthorization, any Error>) {
        guard !isLoading else { return }
        
        self.isLoading = true
        if case .success(let success) = result,
           let cred = success.credential as? ASAuthorizationAppleIDCredential,
           let auth = String(data: cred.authorizationCode ?? Data(), encoding: .utf8)  {
            
            Task {
                do {
                    let _ = try await AuthClient.Authenticate(with: auth)
                    GlobalViewModel.shared.currentUser = try await UserService.CurrentUser()
                }
                catch {
                    self.somethingWentWrong = true
                    self.isLoading = false
                }
            }
        } else {
            self.somethingWentWrong = true
            self.isLoading = false
        }
    }
    
    public func SignIn() {
        guard !isLoading else { return }
        
        self.error = nil
        self.isLoading = true
        let username = userText.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordText
        
        Task {
            do {
                let _ = try await AuthClient.Authenticate(with: username, password: password)
                GlobalViewModel.shared.currentUser = try await UserService.CurrentUser()
                self.isLoading = false
            } catch {
                if let authError = error as? AuthenticationError {
                    if let errorCode = authError.info["error"] as? String, errorCode == "invalid_request" || errorCode == "invalid_grant" {
                        self.error = "Invalid username/email or password"
                    } else if let reason = authError.info["statusCode"] as? Int {
                        switch reason {
                        case 429:
                            self.error = "Too many attempts. Try again later."
                            break
                        default:
                            print(reason)
                            self.somethingWentWrong = true
                            break
                        }
                    } else {
                        self.somethingWentWrong = true
                    }
                } else {
                    self.somethingWentWrong = true
                }
                
                self.isLoading = false
            }
        }
    }
}
