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
import GoTravel_Models

@Observable
public class SignupViewModel {
    
    public var emailField: String = ""
    public var usernameField: String = ""
    public var passwordField: String = ""
    public var confirmPasswordField: String = ""
    
    public var fieldErrors: [SignUpValidError] = []
    public var somethingWentWrong: Bool = false
    
    public var isLoading: Bool = false
        
    public var needsUsernameSet: Bool = false
    public var showNextStep: Bool = false
    
    public var tempUser: CurrentUser? = nil
        
    public struct SignUpValidError {
        let fieldId: String
        let error: LocalizedStringKey
    }
    
    public func errors(for fieldId: String) -> [LocalizedStringKey] {
        return self.fieldErrors.filter { $0.fieldId == fieldId }.compactMap { $0.error }
    }
    
    public func AppleAuthenticate(_ result: Result<ASAuthorization, any Error>) {
        guard !isLoading else { return }
        
        self.isLoading = true
        if case .success(let success) = result,
           let cred = success.credential as? ASAuthorizationAppleIDCredential,
           let auth = String(data: cred.authorizationCode ?? Data(), encoding: .utf8)  {
            
            Task {
                do {
                    let _ = try await AuthClient.Authenticate(with: auth)
                    self.tempUser = try await UserService.CurrentUser()
                    self.needsUsernameSet = true
                    self.showNextStep = true
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
    
    public func Signup() {
        guard !isLoading else { return }
        
        self.isLoading = true
        self.fieldErrors = []
        let email = emailField.trimmingCharacters(in: .whitespacesAndNewlines)
        let username = usernameField.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField
        let passwordConf = confirmPasswordField
        
        if !emailField.isEmail() {
            fieldErrors.append(.init(fieldId: "email", error: Strings.Errors.AuthNotEmail))
        }
        
        if username.count > 25 || username.count < 3 {
            fieldErrors.append(.init(fieldId: "username", error: Strings.Errors.AuthUsernameLength))
        }
        
        if password.count < 8 {
            fieldErrors.append(.init(fieldId: "password", error: Strings.Errors.AuthPasswordLength))
        }
        
        if password != passwordConf {
            fieldErrors.append(.init(fieldId: "password", error: Strings.Errors.AuthPasswordMatch))
            fieldErrors.append(.init(fieldId: "passwordConfirm", error: Strings.Errors.AuthPasswordMatch))
        }
        
        if !fieldErrors.isEmpty {
            self.isLoading = false
            Task {
                await MainActor.run {
                    var errors = ""
                    for error in fieldErrors {
                        errors += "\(error.fieldId): \(error.error.toString())\n"
                    }
                    AccessibilityHelper.postMessage(Strings.Auth.Accessibility.errors(errors).toString(), messageType: .layoutChanged)
                }
            }
            return
        }
        
        Task {
            do {
                let _ = try await AuthClient.SignUp(with: email, password: password, username: username)
                self.tempUser = try await UserService.CurrentUser()
                self.isLoading = false
                self.needsUsernameSet = false
                self.showNextStep = true
            }
            catch {
                if let authError = error as? AuthenticationError {
                    if let reason = authError.info["code"] as? String {
                        switch reason {
                        case "user_exists":
                            fieldErrors.append(.init(fieldId: "email", error: Strings.Errors.AuthEmailTaken))
                            break
                        case "username_exists":
                            fieldErrors.append(.init(fieldId: "username", error: Strings.Errors.AuthUsernameTaken))
                            break
                        case "invalid_password":
                            fieldErrors.append(.init(fieldId: "password", error: Strings.Errors.AuthPasswordSecure))
                            break
                        case "pre_user_registration_validation_error":
                            if let error = authError.info["data"] as? [String:Any], let code = error["customer_error_code"] as? String, code == "username_exists" {
                                fieldErrors.append(.init(fieldId: "username", error: Strings.Errors.AuthUsernameTaken))
                            } else {
                                self.somethingWentWrong = true
                            }
                            break
                        default:
                            self.somethingWentWrong = true
                            break
                        }
                    } else if let error = authError.info["error"] as? String {
                        if error.starts(with: "error in email") {
                            fieldErrors.append(.init(fieldId: "email", error: Strings.Errors.AuthEmailValid))
                        }
                    }
                } else {
                    self.somethingWentWrong = true
                }
                
                self.isLoading = false
                
                if !fieldErrors.isEmpty {
                    Task {
                        await MainActor.run {
                            var errors = ""
                            for error in fieldErrors {
                                errors += "\(error.fieldId): \(error.error.toString())\n"
                            }
                            AccessibilityHelper.postMessage(Strings.Auth.Accessibility.errors(errors).toString(), messageType: .layoutChanged)
                        }
                    }
                }
                
            }
        }
        
    }
}
