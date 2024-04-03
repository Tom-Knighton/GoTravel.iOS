//
//  GlobalViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import SwiftUI
import Observation
import GoTravel_Models
import SwiftData

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
    
    /// The id of a just saved user trip, to present a sheet the user can save from
    public var saveTripId: GVMSaveTripDetails? = nil
    
    /// A win a user can claim
    public var win: ScoreboardWin? = nil
}

@Observable
public class GVMSaveTripDetails: Identifiable, Equatable {
    public static func == (lhs: GVMSaveTripDetails, rhs: GVMSaveTripDetails) -> Bool {
        lhs.saveTripId == rhs.saveTripId
    }
    
    public var saveTripId: PersistentIdentifier
    public var canClose: Bool
    
    public init(saveTripId: PersistentIdentifier, canClose: Bool) {
        self.saveTripId = saveTripId
        self.canClose = canClose
    }
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
