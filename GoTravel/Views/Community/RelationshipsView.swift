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
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Filter...")
    }
    
    @ViewBuilder
    private func followersView(for user: CurrentUser) -> some View {
        
        if user.followers.isEmpty {
            ContentUnavailableView("No Followers", systemImage: "xmark", description: Text("You don't have any followers yet, spread the word!"))
        }
        
        
        Spacer().frame(height: 16)
        LazyVStack {
            ForEach(user.followers.filter { self.searchText.isEmpty || $0.userName.localizedCaseInsensitiveContains(self.searchText) }, id: \.userName) { user in
                HStack {
                    AsyncImage(url: URL(string: user.userPictureUrl)) { img in
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 34, height: 34)
                            .clipShape(.circle)
                            .shadow(radius: 3)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 34, height: 34)
                    }
                    
                    Text(user.userName)
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Remove")
                    }
                    .buttonStyle(.bordered)
                    .font(.subheadline)
                }
                Divider()
            }
        }
    }
    
    @ViewBuilder
    private func followingView(for user: CurrentUser) -> some View {
        
        if user.following.isEmpty {
            ContentUnavailableView("No Followers", systemImage: "xmark", description: Text("You don't have any followers yet, spread the word!"))
        }
        
        
        Spacer().frame(height: 16)
        LazyVStack {
            ForEach(user.following.filter { self.searchText.isEmpty || $0.userName.localizedCaseInsensitiveContains(self.searchText) }, id: \.userName) { user in
                HStack {
                    AsyncImage(url: URL(string: user.userPictureUrl)) { img in
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 34, height: 34)
                            .clipShape(.circle)
                            .shadow(radius: 3)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 34, height: 34)
                    }
                    
                    Text(user.userName)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Unfollow")
                    }
                    .buttonStyle(.bordered)
                    .font(.subheadline)
                    
                }
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
    let following: [User] = [
        .init(userName: "Test 5", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1),
        .init(userName: "Test 6", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1),
        .init(userName: "Test 8", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1),
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
