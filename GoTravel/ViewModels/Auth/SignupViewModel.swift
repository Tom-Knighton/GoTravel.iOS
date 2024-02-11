//
//  SignupViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 11/02/2024.
//

import Foundation
import Observation
import AuthenticationServices
import SwiftUI
import GoTravel_API
import Auth0

@Observable
public class SignupViewModel {
    
    public var emailField: String = ""
    public var usernameField: String = ""
    public var passwordField: String = ""
    public var confirmPasswordField: String = ""
    
    public var fieldErrors: [SignUpValidError] = []
    public var somethingWentWrong: Bool = false
    
    public var isLoading: Bool = false
    
    public struct SignUpValidError {
        let fieldId: String
        let error: LocalizedStringKey
    }
    
    public func errors(for fieldId: String) -> [LocalizedStringKey] {
        return self.fieldErrors.filter { $0.fieldId == fieldId }.compactMap { $0.error }
    }
    
    public func AppleAuthenticate(_ result: Result<ASAuthorization, any Error>) {
        guard !isLoading else { return }
    }
    
    public func Signup() {
        guard !isLoading else { return }
        
        self.isLoading = true
        self.fieldErrors = []
        let email = emailField.trimmingCharacters(in: .whitespacesAndNewlines)
        let username = usernameField.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField
        let passwordConf = confirmPasswordField
        
        if !emailField.isEmail() {
            fieldErrors.append(.init(fieldId: "email", error: "Must be an email"))
        }
        
        if username.count > 25 || username.count < 3 {
            fieldErrors.append(.init(fieldId: "username", error: "Must be between 3 and 25 characters"))
        }
        
        if password.count < 8 {
            fieldErrors.append(.init(fieldId: "password", error: "Must be more than 8 characters"))
        }
        
        if password != passwordConf {
            fieldErrors.append(.init(fieldId: "password", error: "Passwords must match"))
            fieldErrors.append(.init(fieldId: "passwordConfirm", error: "Passwords must match"))
        }
        
        if !fieldErrors.isEmpty {
            self.isLoading = false
            return
        }
        
        Task {
            do {
                let success = try await AuthClient.SignUp(with: email, password: password, username: username)
                self.isLoading = false
            }
            catch {
                if let authError = error as? AuthenticationError {
                    if let reason = authError.info["code"] as? String {
                        switch reason {
                        case "user_exists":
                            fieldErrors.append(.init(fieldId: "email", error: "This email address already belongs to a user"))
                            break
                        case "username_exists":
                            fieldErrors.append(.init(fieldId: "username", error: "This username is already taken"))
                            break
                        case "invalid_password":
//                            let message = authError.info["policy"] as? String
                            fieldErrors.append(.init(fieldId: "password", error: "Your password is not secure enough, it must contain a special character, capital letters, numbers and be over 8 characters"))
                            break
                        default:
                            break
                        }
                    } else if let error = authError.info["error"] as? String {
                        if error.starts(with: "error in email") {
                            fieldErrors.append(.init(fieldId: "email", error: "Please enter a valid email address"))
                        }
                    }
                } else {
                    self.somethingWentWrong = true
                }
                
                self.isLoading = false
            }
        }
        
    }
}
