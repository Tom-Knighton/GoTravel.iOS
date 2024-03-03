//
//  CommunityPageHeader.swift
//  GoTravel
//
//  Created by Tom Knighton on 29/02/2024.
//

import SwiftUI
import GoTravel_Models


public struct CommunityPageHeader: View {
    
    @Environment(GlobalViewModel.self) private var globalVm
    
    @State private var showProfileSheet: Bool = false
    @State private var relationshipViewOpenTo: Int? = nil

    
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { self.relationshipViewOpenTo = 0 } ) {
                    Label(String(describing: globalVm.currentUser?.followers.count ?? 0), systemImage: Icons.threePeopleFilled)
                        .bold()
                }
                .tint(.primary)
                .accessibilityHint(Strings.Community.Accessibility.ManageFollowersHint)
            }
            
            VStack {
                HStack {
                    Text(Strings.Community.Updates.Title)
                        .font(.headline.bold())
                    Spacer()
                    
                    Button(action: { self.relationshipViewOpenTo = 1 }) {
                        Label(Strings.Community.Updates.FollowingCount(globalVm.currentUser?.following.count ?? 0), systemImage: Icons.threePeopleSeq)
                    }
                    .tint(.primary)
                    .accessibilityHint(Strings.Community.Accessibility.ManageFollowingHint)
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
        .sheet(item: $relationshipViewOpenTo) { relView in
            RelationshipsView(openToType: relView == 0 ? .followers : relView == 1 ? .following : .blocked)
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
        .accessibilityLabel(Strings.Community.Accessibility.ProfilePicLabel)
        .accessibilityHint(Strings.Community.Accessibility.ProfilePicHint)
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
