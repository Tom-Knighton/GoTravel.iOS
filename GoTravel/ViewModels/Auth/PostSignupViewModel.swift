//
//  PostSignupViewModek.swift
//  GoTravel
//
//  Created by Tom Knighton on 15/02/2024.
//

import Foundation
import Observation
import SwiftUI
import PhotosUI
import UIKit
import GoTravel_API
import GoTravel_Models

@Observable
public class PostSignupViewModel {
    
    public var userChosenFile: PhotosPickerItem? = nil
    public var userImage: UIImage? = nil
    public var usernameText: String = ""
    public var fieldErrors: [PostSignUpValidError] = []
    public var isLoading: Bool = false
    public var somethingWentWrong: Bool = false
    
    public var tempUser: CurrentUser?
    
    public struct PostSignUpValidError {
        let fieldId: String
        let error: LocalizedStringKey
    }
    
    public func setup(with user: CurrentUser?) {
        self.tempUser = user
    }
    
    public func saveUser() {
        guard !isLoading else { return }
                
        self.isLoading = true
        self.fieldErrors = []
        
        guard let tempUser else { return }
        
        let username = usernameText.trimmingCharacters(in: .whitespacesAndNewlines)

        if needsUsernameSet() && (username.count > 25 || username.count < 3) {
            fieldErrors.append(.init(fieldId: "username", error: Strings.Errors.AuthUsernameLength))
        }
        
        if !fieldErrors.isEmpty {
            self.isLoading = false
            return
        }
        
        Task {
            do {
                if let userImage {
                    if let data = userImage.jpegData(compressionQuality: 0.7) {
                        let profilePicSuccess = try await UserService.UpdateProfilePic(for: tempUser.userName, to: data)
                        if !profilePicSuccess {
                            throw "Failed to set profile picture"
                        }
                    }
                }
                
                if needsUsernameSet() && username != tempUser.userName {
                    let updateSuccess = try await UserService.UpdateDetails(for: tempUser.userName, to: .init(username: username))
                    if !updateSuccess {
                        throw "Failed to update user"
                    }
                }
                
                GlobalViewModel.shared.currentUser = try await UserService.CurrentUser()
            } catch {
                self.somethingWentWrong = true
                self.isLoading = false
            }
        }
    }
    
    public func needsUsernameSet() -> Bool {
        let isApple = tempUser?.userId.starts(with: "apple|") == true
        
        return isApple
    }
}
