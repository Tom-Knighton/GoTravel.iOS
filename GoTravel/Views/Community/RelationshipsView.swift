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
                        Text(Strings.Community.Relationships.Followers).tag(RelType.followers)
                        Text(Strings.Community.Relationships.Following).tag(RelType.following)
                        Text(Strings.Community.Relationships.Blocked).tag(RelType.blocked)
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
            .navigationTitle(Strings.Community.Relationships.Friendships)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { self.addFriendSheet = true }) {
                        HStack {
                            Image(systemName: Icons.magnifyingGlass)
                            Text(Strings.Community.Relationships.AddFriend)
                        }                           
                    }
                    .accessibilityHint(Strings.Community.Accessibility.AddFriendBtnHint)
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Strings.Misc.Filter)
        .sheet(isPresented: $addFriendSheet) {
            UserSearchView()
        }
    }
    
    @ViewBuilder
    private func followersView(for user: CurrentUser) -> some View {
        
        if user.followers.isEmpty {
            ContentUnavailableView(Strings.Community.Relationships.NoFollowers, systemImage: Icons.cross, description: Text(Strings.Community.Relationships.NoFollowersDesc))
        }
        
        
        Spacer().frame(height: 16)
        LazyVStack {
            ForEach(user.followers.filter { self.searchText.isEmpty || $0.user.userName.localizedCaseInsensitiveContains(self.searchText) }, id: \.user.userName) { following in
                UserRowView(user: following.user, type: .Followers)
                Divider()
            }
        }
    }
    
    @ViewBuilder
    private func followingView(for user: CurrentUser) -> some View {
        
        if user.following.isEmpty {
            ContentUnavailableView(Strings.Community.Relationships.NoFollowing, systemImage: Icons.cross, description: Text(Strings.Community.Relationships.NoFollowingDesc))
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
        
        ContentUnavailableView(Strings.Community.Relationships.NoBlocked, systemImage: Icons.cross, description: Text(Strings.Community.Relationships.NoBlockedDesc))
    }
}

#if DEBUG
#Preview {
    
    let global = GlobalViewModel()
    global.currentUser = PreviewUserData.Current
    
    
    return VStack {
        
    }
    .sheet(isPresented: .constant(true), content: {
        RelationshipsView()
            .interactiveDismissDisabled()
    })
    .environment(global)
}
#endif
