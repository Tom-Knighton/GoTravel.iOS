//
//  CommunityPage.swift
//  GoTravel
//
//  Created by Tom Knighton on 18/02/2024.
//

import SwiftUI
import GoTravel_API
import GoTravel_Models

public struct CommunityPage: View {
    
    @Environment(GlobalViewModel.self) private var globalVm
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            
            
            if let user = globalVm.currentUser {
                ScrollView {
                    VStack {
                        CommunityPageHeader()
                        Spacer()
                    }
                }
                .navigationTitle(Strings.Navigation.CommunityTab)
                .contentMargins(.horizontal, 16, for: .scrollContent)

            } else {
                CommunityNotLoggedInView()
                    .navigationTitle(Strings.Navigation.CommunityTab)
            }
        }
    }
}

#Preview {
    
    let global = GlobalViewModel()
    global.currentUser = CurrentUser(userId: "auth0|Id", userName: "tomknighton", userEmail: "tomknighton@icloud.com", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", dateCreated: Date())
    
    return NavigationStack {
        CommunityPage()
    }
    .environment(global)
}
