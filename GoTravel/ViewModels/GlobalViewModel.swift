//
//  GlobalViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import SwiftUI
import Observation

@Observable
public class GlobalViewModel {
    
    @ObservationIgnored
    public static let shared = GlobalViewModel()
    
    /// The navigation path used for the 'map' tab
    public var mapPath = NavigationPath()
    
    /// The current index of the selected tab at the root of the app
    public var tabIndex: Int = 0
}

extension GlobalViewModel {
    
    public func addToCurrentNavStack(_ value: any Hashable) {
        switch self.tabIndex {
        case 0:
            self.mapPath.append(value)
        default:
            print("WARN: current nav stack unknown (\(self.tabIndex))")
        }
    }
}
