//
//  UserRowView.swift
//  GoTravel
//
//  Created by Tom Knighton on 02/03/2024.
//

import SwiftUI
import GoTravel_Models
import GoTravel_API

public struct UserRowView: View {

    public enum UserRowViewType {
        case Default
        case Followers
        case Following
        case Blocked
    }
    
    @Environment(GlobalViewModel.self) private var globalVm
    @State private var isPerformingAction: Bool = false
    public let user: User
    public var type: UserRowViewType = .Default
    
    public var body: some View {
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
            
            actionButton()
                .disabled(self.isPerformingAction)
        }
    }
    
    @ViewBuilder
    private func actionButton() -> some View {
        if let current = globalVm.currentUser {
            
            if self.isPerformingAction {
                Button(action: {}) {
                    ProgressView()
                }
            }
            else {
                switch self.type {
                case .Default:
                    if let following = current.following.first(where: { $0.user.userName == user.userName }) {
                        switch following.followingType {
                        case .following:
                            Button(action: { Task { await self.unfollow() } }) {
                                Text("Unfollow")
                            }
                            .buttonStyle(.bordered)
                            .font(.subheadline)
                        case .requested:
                            Button(action: {}) {
                                Text("Requested")
                            }
                            .buttonStyle(.bordered)
                            .font(.subheadline)
                        case .blocked:
                            Button(action: {}) {
                                Text("Unblock")
                            }
                            .buttonStyle(.bordered)
                            .font(.subheadline)
                        }
                    } else if let followed = current.followers.first(where: { $0.user.userName == user.userName }) {
                        switch followed.followingType {
                        case .following:
                            Button(action: { Task { await self.removeFollower() }}) {
                                Text("Remove")
                            }
                            .buttonStyle(.bordered)
                            .font(.subheadline)
                        case .requested:
                            HStack {
                                Button(action: { Task { await self.respondToRequest(approve: true) }}) {
                                    Text("Approve")
                                }
                                .buttonStyle(.bordered)
                                .font(.subheadline)
                                Button(action: { Task { await self.respondToRequest(approve: false) }}) {
                                    Text("Reject")
                                }
                                .buttonStyle(.bordered)
                                .font(.subheadline)
                                .tint(.red)
                            }
                        case .blocked:
                            EmptyView()
                        }
                       
                    } else {
                        Button(action: { Task { await self.requestFollow() }}) {
                            Text("Add Friend")
                        }
                        .buttonStyle(.bordered)
                        .font(.subheadline)
                    }
                case .Followers:
                    if let follower = current.followers.first(where: { $0.user.userName == user.userName }) {
                        switch follower.followingType {
                        case .following:
                            Button(action: { Task { await self.removeFollower() }}) {
                                Text("Remove")
                            }
                            .buttonStyle(.bordered)
                            .font(.subheadline)
                        case .requested:
                            HStack {
                                Button(action: { Task { await self.respondToRequest(approve: true) }}) {
                                    Text("Approve")
                                }
                                .buttonStyle(.bordered)
                                .font(.subheadline)
                                Button(action: { Task { await self.respondToRequest(approve: false) }}) {
                                    Text("Reject")
                                }
                                .buttonStyle(.bordered)
                                .font(.subheadline)
                                .tint(.red)
                            }
                        case .blocked:
                            EmptyView()
                        }

                    }
                case .Following:
                    if let follower = current.following.first(where: { $0.user.userName == user.userName }) {
                        if follower.followingType == .requested {
                            Button(action: {}) {
                                Text("Requested")
                            }
                            .buttonStyle(.bordered)
                            .font(.subheadline)
                        } else {
                            Button(action: { Task { await self.unfollow() }}) {
                                Text("Unfollow")
                            }
                            .buttonStyle(.bordered)
                            .font(.subheadline)
                        }
                    } else {
                        Button(action: { Task { await self.unfollow() }}) {
                            Text("Unfollow")
                        }
                        .buttonStyle(.bordered)
                        .font(.subheadline)
                    }
                case .Blocked:
                    Button(action: {}) {
                        Text("Unblock")
                    }
                    .buttonStyle(.bordered)
                    .font(.subheadline)
                    .tint(.red)
                }
            }
        }
    }
    
    private func requestFollow() async {
        self.isPerformingAction = true
        defer { self.isPerformingAction = false }
        
        do {
            let result = try await FriendshipsService.updateFriendship(followingId: user.userName, to: true)
            if result {
                globalVm.currentUser = try await UserService.CurrentUser()
            }
        } catch {
            print(error)
        }
        
    }
    
    private func unfollow() async {
        self.isPerformingAction = true
        defer { self.isPerformingAction = false }
        
        do {
            let result = try await FriendshipsService.updateFriendship(followingId: user.userName, to: false)
            if result {
                globalVm.currentUser = try await UserService.CurrentUser()
            }
        } catch {
            print(error)
        }
        
    }
    
    private func removeFollower() async {
        self.isPerformingAction = true
        defer { self.isPerformingAction = false }
        
        do {
            let result = try await FriendshipsService.removeFollower(followerId: user.userName)
            if result {
                globalVm.currentUser = try await UserService.CurrentUser()
            }
        } catch {
            print(error)
        }
    }
    
    private func respondToRequest(approve: Bool) async {
        self.isPerformingAction = true
        defer { self.isPerformingAction = false }
        
        do {
            let result = try await FriendshipsService.respondToRequest(requesterId: user.userName, accept: approve)
            if result {
                globalVm.currentUser = try await UserService.CurrentUser()
            }
        } catch {
            print(error)
        }
    }
}
