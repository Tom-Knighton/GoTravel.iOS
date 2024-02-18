//
//  CommunityPage.swift
//  GoTravel
//
//  Created by Tom Knighton on 18/02/2024.
//

import SwiftUI
import GoTravel_API

public struct CommunityPage: View {
    
    @Environment(GlobalViewModel.self) private var globalVm
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            
            
            if let user = globalVm.currentUser {
                VStack {
                    Text("Hey \(user.userName)!")
                    Button(action: { Task {
                        try? await AuthClient.LogOut()
                        GlobalViewModel.shared.currentUser = nil
                    } }) {
                        Text("Logout")
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                CommunityNotLoggedInView()
                    .navigationTitle("Community")
            }
        }
    }
}
