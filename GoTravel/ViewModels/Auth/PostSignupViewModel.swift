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

@Observable
public class PostSignupViewModel {
    
    public var userChosenFile: PhotosPickerItem? = nil
    public var userImage: UIImage? = nil
    public var usernameText: String = GlobalViewModel.shared.currentUser?.userName ?? ""
    
    public var isLoading: Bool = false
    
    init() {
        
    }
    
    public func needsUsernameSet() -> Bool {
        let isApple = GlobalViewModel.shared.currentUser?.userId.starts(with: "apple|") == true
        
        return !isApple
    }
}
