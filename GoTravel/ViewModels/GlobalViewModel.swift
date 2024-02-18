//
//  GlobalViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import SwiftUI
import Observation
import GoTravel_Models

@Observable
public class GlobalViewModel {
    
    @ObservationIgnored
    public static let shared = GlobalViewModel()
    
    /// If logged in, details on the current user
    public var currentUser: CurrentUser?
    
    /// The navigation path used for the 'map' tab
    public var mapPath = NavigationPath()
    
    // The navigation path used for the 'journey' tab
    public var journeyPath = NavigationPath()
    
    // The navigation path used for the 'community' tab
    public var communityPath = NavigationPath()
    
    /// The current index of the selected tab at the root of the app
    public var tabIndex: Int = 0
}

extension GlobalViewModel {
    
    public func addToCurrentNavStack(_ value: any Hashable) {
        switch self.tabIndex {
        case 0:
            self.mapPath.append(value)
        case 1:
            self.journeyPath.append(value)
        case 2:
            self.communityPath.append(value)
        default:
            print("WARN: current nav stack unknown (\(self.tabIndex))")
        }
    }
}
