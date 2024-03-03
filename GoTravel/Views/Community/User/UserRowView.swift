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
            .accessibilityHidden()
            
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
                ProgressView()
            }
            else {
                switch self.type {
                case .Default:
                    if let following = current.following.first(where: { $0.user.userName == user.userName }) {
                        switch following.followingType {
                        case .following:
                            unfollowButton()
                        case .requested:
                            requestedButton()
                        case .blocked:
                            unblockButton()
                        }
                    } else if let followed = current.followers.first(where: { $0.user.userName == user.userName }) {
                        switch followed.followingType {
                        case .following:
                            removeButton()
                        case .requested:
                            HStack {
                                approveButton()
                                rejectButton()
                            }
                        case .blocked:
                            unblockButton()
                        }
                       
                    } else {
                        requestButton()
                    }
                case .Followers:
                    if let follower = current.followers.first(where: { $0.user.userName == user.userName }) {
                        switch follower.followingType {
                        case .following:
                            removeButton()
                        case .requested:
                            HStack {
                                approveButton()
                                rejectButton()
                            }
                        case .blocked:
                            unblockButton()
                        }

                    }
                case .Following:
                    if let follower = current.following.first(where: { $0.user.userName == user.userName }) {
                        if follower.followingType == .requested {
                            requestedButton()
                        } else {
                            unfollowButton()
                        }
                    } else {
                        unfollowButton()
                    }
                case .Blocked:
                    unblockButton()
                }
            }
        }
    }
    
    @ViewBuilder
    private func unblockButton() -> some View {
        Button(action: {}) {
            Text(Strings.Community.Relationships.Unblock)
        }
        .buttonStyle(.bordered)
        .font(.subheadline)
        .tint(.red)
        .accessibilityHint(Strings.Community.Accessibility.UnblockHint)
    }
    
    @ViewBuilder
    private func unfollowButton() -> some View {
        Button(action: { Task { await self.unfollow() }}) {
            Text(Strings.Community.Relationships.Unfollow)
        }
        .buttonStyle(.bordered)
        .font(.subheadline)
        .accessibilityHint(Strings.Community.Accessibility.UnfollowHint)
    }
    
    @ViewBuilder
    private func requestedButton() -> some View {
        Button(action: {}) {
            Text(Strings.Community.Relationships.Requested)
        }
        .buttonStyle(.bordered)
        .font(.subheadline)
        .accessibilityHint(Strings.Community.Accessibility.RequestedHint)
    }
    
    @ViewBuilder
    private func approveButton() -> some View {
        Button(action: { Task { await self.respondToRequest(approve: true) }}) {
            Text(Strings.Community.Relationships.Approve)
        }
        .buttonStyle(.bordered)
        .font(.subheadline)
        .accessibilityHint(Strings.Community.Accessibility.ApproveHint)
        .accessibilityRemoveTraits(.isButton)
    }
    
    @ViewBuilder
    private func rejectButton() -> some View {
        Button(action: { Task { await self.respondToRequest(approve: false) }}) {
            Text(Strings.Community.Relationships.Reject)
        }
        .buttonStyle(.bordered)
        .font(.subheadline)
        .tint(.red)
        .accessibilityHint(Strings.Community.Accessibility.RejectHint)
    }
    
    @ViewBuilder
    private func removeButton() -> some View {
        Button(action: { Task { await self.removeFollower() }}) {
            Text(Strings.Community.Relationships.Remove)
        }
        .buttonStyle(.bordered)
        .font(.subheadline)
        .accessibilityHint(Strings.Community.Accessibility.RemoveHint)
    }
    
    
    @ViewBuilder
    private func requestButton() -> some View {
        Button(action: { Task { await self.requestFollow() }}) {
            Text(Strings.Community.Relationships.AddFriend)
        }
        .buttonStyle(.bordered)
        .font(.subheadline)
        .accessibilityHint(Strings.Community.Accessibility.RequestHint)
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
