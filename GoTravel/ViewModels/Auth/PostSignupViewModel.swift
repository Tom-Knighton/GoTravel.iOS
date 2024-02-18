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
    public var usernameText: String = GlobalViewModel.shared.currentUser?.userName ?? ""
    public var fieldErrors: [PostSignUpValidError] = []
    public var isLoading: Bool = false
    public var somethingWentWrong: Bool = false
    
    public struct PostSignUpValidError {
        let fieldId: String
        let error: LocalizedStringKey
    }
    
    public func saveUser() {
        guard !isLoading else { return }
        
        guard let currentUser = GlobalViewModel.shared.currentUser else { return }
        
        self.isLoading = true
        self.fieldErrors = []
        
        let username = usernameText.trimmingCharacters(in: .whitespacesAndNewlines)

        if username.count > 25 || username.count < 3 {
            fieldErrors.append(.init(fieldId: "username", error: "Must be between 3 and 25 characters"))
        }
        
        if !fieldErrors.isEmpty {
            self.isLoading = false
            return
        }
        
        Task {
            do {
                if let userImage {
                    if let data = userImage.jpegData(compressionQuality: 0.7) {
                        let profilePicSuccess = try await UserService.UpdateProfilePic(for: currentUser.userName, to: data)
                        if !profilePicSuccess {
                            throw "Failed to set profile picture"
                        }
                    }
                }
                
                if username != currentUser.userName {
                    let updateSuccess = try await UserService.UpdateDetails(for: currentUser.userName, to: .init(username: username))
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
        let isApple = GlobalViewModel.shared.currentUser?.userId.starts(with: "apple|") == true
        
        return isApple
    }
}
