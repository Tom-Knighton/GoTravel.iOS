//
//  UserSearchView.swift
//  GoTravel
//
//  Created by Tom Knighton on 01/03/2024.
//

import SwiftUI
import GoTravel_Models
import GoTravel_API
import Combine

public struct UserSearchView: View {
    
    @State private var searchText: String = ""
    @State private var loading: Bool = false
    @State private var users: [User] = []
    let searchTextPublisher = PassthroughSubject<String, Never>()

    public var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    if searchText.isEmpty {
                        ContentUnavailableView("Search for users", systemImage: "magnifyingglass", description: Text("Search for friends to add and follow their travels, and compete against them!"))
                    }
                    
                    if searchText.count >= 3 {
                        if loading {
                            ProgressView()
                        } else {
                            if users.isEmpty {
                                ContentUnavailableView("No results", systemImage: "xmark", description: Text("There were no results for this search."))
                            } else {
                                ForEach(users, id: \.userName) { user in
                                    UserRowView(user: user, type: .Default)
                                }
                                Spacer()
                            }
                        }
                    }
                    
                }
            }
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .navigationTitle("Add Friend")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for users...")
            .onChange(of: self.searchText, { _, newValue in
                self.searchTextPublisher.send(newValue)
            })
            .onReceive(searchTextPublisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main), perform: { val in
                let trimmed = val.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmed.count >= 3 {
                    Task {
                        await searchUsers(with: val)
                    }
                }
               
            })
        }
        
    }
    
    private func searchUsers(with query: String) async {
        self.loading = true
        defer { self.loading = false }
        
        do {
            let users = try await UserService.Search(for: query)
            self.users = users
        } catch {
            self.users = []
            print("error")
        }
    }
}


#Preview {
    let global = GlobalViewModel()
    
    let followers: [UserFollowing] = [
        .init(followingType: .following, user: .init(userName: "Test 1", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)),
        .init(followingType: .following, user: .init(userName: "Test 2", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)),
        .init(followingType: .following, user: .init(userName: "Test 3", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)),
    ]
    let following: [UserFollowing] = [
        .init(followingType: .following, user: .init(userName: "Test 5", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)),
        .init(followingType: .following, user: .init(userName: "Test 6", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)),
        .init(followingType: .following, user: .init(userName: "Test 8", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", followerCount: 1)),
    ]
    global.currentUser = CurrentUser(userId: "auth0|Id", userName: "tomknighton", userEmail: "tomknighton@icloud.com", userPictureUrl: "https://cdn.tomk.online/gotravel/Users/auth0|65d254c562315443371df109/03b6a22d25974a26b65e1852a2b636a9.jpg", dateCreated: Date(), followers: followers, following: following)
    
    return NavigationStack {
        UserSearchView()
    }
    .environment(global)
    
}
