//
//  NavigationPath+GoLondon.swift
//  GoLondon
//
//  Created by Tom Knighton on 08/10/2023.
//

import SwiftUI

extension NavigationPath {
    
    /// Pops the last n views.
    /// If `levels` is larger than the number of actual values in the path, stack will pop to root instead
    public mutating func goBack(_ levels: Int = 1) {
        if levels >= self.count {
            self.popToRootView()
            return
        }
        
        self.removeLast(levels)
    }
    
    /// Removes all values from the navigation path and pops to the root view
    public mutating func popToRootView() {
        self.removeLast(self.count)
    }
}
