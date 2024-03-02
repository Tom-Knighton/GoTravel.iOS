//
//  RelationshipsView.swift
//  GoTravel
//
//  Created by Tom Knighton on 01/03/2024.
//

import SwiftUI
import GoTravel_Models

public struct RelationshipsView: View {
    
    enum RelType {
        case followers
        case following
        case blocked
    }
    
    @Environment(GlobalViewModel.self) private var globalVm
    @State private var selection: RelType = .followers
    @State private var searchText: String = ""
    @State private var addFriendSheet: Bool = false
    
    init(openToType: RelType = .followers) {
        self._selection = State(wrappedValue: openToType)
    }
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Picker("", selection: $selection) {
                        Text("Followers").tag(RelType.followers)
                        Text("Following").tag(RelType.following)
                        Text("Blocked").tag(RelType.blocked)
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    
                    if let user = globalVm.currentUser {
                        switch self.selection {
                        case .followers:
                            followersView(for: user)
                        case .following:
                            followingView(for: user)
                        case .blocked:
                            blockedView(for: user)
                        }
                    }
                    
                    Spacer()
                }
            }
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .toolbarTitleDisplayMode(.large)
            .navigationTitle("Friendships")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { self.addFriendSheet = true }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Add friend")
                        }                           
                    }
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Filter...")
        .sheet(isPresented: $addFriendSheet) {
            UserSearchView()
        }
    }
    
    @ViewBuilder
    private func followersView(for user: CurrentUser) -> some View {
        
        if user.followers.isEmpty {
            ContentUnavailableView("No Followers", systemImage: "xmark", description: Text("You don't have any followers yet, spread the word!"))
        }
        
        
        Spacer().frame(height: 16)
        LazyVStack {
            ForEach(user.followers.filter { self.searchText.isEmpty || $0.userName.localizedCaseInsensitiveContains(self.searchText) }, id: \.userName) { user in
                UserRowView(user: user, type: .Followers)
                Divider()
            }
        }
    }
    
    @ViewBuilder
    private func followingView(for user: CurrentUser) -> some View {
        
        if user.following.isEmpty {
            ContentUnavailableView("No one's here...", systemImage: "xmark", description: Text("You're not following anyone yet, follow a friend to see their updates and compete against them!"))
        }
        
        
        Spacer().frame(height: 16)
        LazyVStack {
            ForEach(user.following.filter { self.searchText.isEmpty || $0.user.userName.localizedCaseInsensitiveContains(self.searchText) }, id: \.user.userName) { following in
                UserRowView(user: following.user, type: .Following)
                Divider()
            }
        }
    }
    
    @ViewBuilder
    private func blockedView(for user: CurrentUser) -> some View {
        
        ContentUnavailableView("You haven't blocked anyone", systemImage: "xmark", description: Text("You haven't blocked any users yet. If you do, they will appear here and you can choose to unblock them."))
    }
}

#Preview {
    
    let global = GlobalViewModel()
    
    let followers: [User] = [
        .init(userName: "Test 1", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1),
        .init(userName: "Test 2", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1),
        .init(userName: "Test 3", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1),
    ]
    let following: [UserFollowing] = [
        .init(followingType: .following, user: .init(userName: "Test 5", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)),
        .init(followingType: .following, user: .init(userName: "Test 6", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)),
        .init(followingType: .following, user: .init(userName: "Test 8", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)),
    ]
    global.currentUser = CurrentUser(userId: "auth0|Id", userName: "tomknighton", userEmail: "tomknighton@icloud.com", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", dateCreated: Date(), followers: followers, following: following)
    
    
    return VStack {
        
    }
    .sheet(isPresented: .constant(true), content: {
        RelationshipsView()
            .interactiveDismissDisabled()
    })
    .environment(global)
}
