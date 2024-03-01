//
//  CommunityPageHeader.swift
//  GoTravel
//
//  Created by Tom Knighton on 29/02/2024.
//

import SwiftUI
import GoTravel_Models
@_spi(Advanced) import SwiftUIIntrospect


public struct CommunityPageHeader: View {
    
    @Environment(GlobalViewModel.self) private var globalVm
    
    @State private var showProfileSheet: Bool = false

    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                Label("2", systemImage: "person.3.fill")
                    .bold()
            }
            
            VStack {
                HStack {
                    Text("Updates:")
                        .font(.headline.bold())
                    Spacer()
                    Label("5 Following", systemImage: "person.3.sequence")
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(Color.layer2)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 3)
        }
        
        .fontDesign(.rounded)
        .customNavigationTitleWithRightIcon {
            barContent()
        }
    }
    
    @ViewBuilder
    private func barContent() -> some View {
        Button(action: { self.showProfileSheet = true }) {
            AsyncImage(url: URL(string: globalVm.currentUser?.userPictureUrl ?? "")) { img in
                img
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 34, height: 34)
                    .clipShape(.circle)
                    .shadow(radius: 3)
            } placeholder: {
                ProgressView()
                    .frame(width: 34, height: 34)
                    .clipShape(.circle)
                    .shadow(radius: 3)
            }
        }
//        .sheet(isPresented: $showProfileSheet, content: {
//            VStack {
//                
//            }
//        })
    }
}


#Preview {
    
    let global = GlobalViewModel()
    global.currentUser = CurrentUser(userId: "auth0|Id", userName: "tomknighton", userEmail: "tomknighton@icloud.com", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", dateCreated: Date())
    
    return NavigationStack {
        ScrollView {
            VStack {
                CommunityPageHeader()
            }
            .navigationTitle("Community")
            .environment(global)
        }
        .contentMargins(.horizontal, 16, for: .scrollContent)
    }
}
