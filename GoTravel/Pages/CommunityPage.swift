//
//  CommunityPage.swift
//  GoTravel
//
//  Created by Tom Knighton on 18/02/2024.
//

import SwiftUI

public struct CommunityPage: View {
    
    @Environment(GlobalViewModel.self) private var globalVm
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            
            if let user = globalVm.currentUser {
                Text("Hey \(user.userName)!")
            } else {
                Text("pls log in")
            }
        }
    }
}
