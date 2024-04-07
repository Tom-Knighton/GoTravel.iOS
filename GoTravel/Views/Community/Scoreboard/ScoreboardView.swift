//
//  ScoreboardView.swift
//  GoTravel
//
//  Created by Tom Knighton on 31/03/2024.
//

import SwiftUI
import GoTravel_Models

public struct ScoreboardView: View {
    
    @Environment(GlobalViewModel.self) private var globalVM
    @State private var viewModel = ScoreboardViewModel()
    
    public var id: String
    
    public var body: some View {
        VStack {
            if let scoreboard = viewModel.scoreboard {
                scoreboardView(scoreboard)
            }
        }
        .task {
#if targetEnvironment(simulator)
            viewModel.scoreboard = Scoreboard(scoreboardId: "", scoreboardName: "Most Travel", scoreboardDescription: "Compete against friends to use the most public transport!", scoreboardLogoUrl: "", startDate: Date(), endDate: Date(), doesReset: false, scoreboardUsers: [.init(rank: 1, points: 100, user: PreviewUserData.User2), .init(rank: 2, points: 100, user: PreviewUserData.User5), .init(rank: 4, points: 100, user: PreviewUserData.User4)])
#else
            await viewModel.load(id)
#endif
        }
    }
    
    
    @ViewBuilder
    private func scoreboardView(_ scoreboard: Scoreboard) -> some View {
        VStack {
            VStack {
                Text(scoreboard.scoreboardName)
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontDesign(.rounded)
                Text(scoreboard.scoreboardDescription)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontDesign(.rounded)

                Group {
                    if let endsAt = scoreboard.endDate {
                        if endsAt > Date() {
                            if Date().timeUntil(endsAt, unit: .hours) < 24 {
                                if scoreboard.doesReset {
                                    Text(Strings.Community.Scoreboard.ResetsSoon)
                                } else {
                                    Text(Strings.Community.Scoreboard.EndsSoon)
                                }
                            }
                        } else {
                            Text(Strings.Community.Scoreboard.Closed)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .fontDesign(.rounded)
                
                ForEach(scoreboard.scoreboardUsers, id: \.user.userName) { user in
                    VStack {
                        if user.user.userName == globalVM.currentUser?.userName && userIsOutOfRange() {
                            Text("....")
                        }
                        HStack {
                            AsyncImage(url: URL(string: user.user.userPictureUrl)) { img in
                                img
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 30, height: 30)
                                    .clipShape(.circle)
                                    .shadow(radius: 50)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                            .accessibilityHidden()
                            
                            VStack(alignment: .leading) {
                                Text(user.user.userName)
                                if let subtitle = user.user.subtitle {
                                    Text(subtitle)
                                        .font(.custom("Silkscreen-Regular", size: 16))
                                        .foregroundStyle(
                                            LinearGradient(
                                                        colors: [.red, .blue, .green, .yellow],
                                                        startPoint: .bottomLeading,
                                                        endPoint: .topTrailing
                                                    )
                                        )
                                }
                            }
                            if user.user.userName == globalVM.currentUser?.userName && userIsOutOfRange() {
                                Text(Strings.Community.Scoreboard.Pos(user.rank))
                            }
                            
                            Spacer()
                            
                            Text(String(describing: user.points))
                                .bold()
                            
                            switch user.rank {
                            case 1:
                                Image(systemName: Icons.trophyFill)
                                    .foregroundStyle(.yellow)
                            case 2:
                                Image(systemName: Icons.trophy)
                                    .foregroundStyle(.gray)
                            case 3:
                                Image(systemName: Icons.trophy)
                                    .foregroundStyle(.red)
                            default:
                                EmptyView()
                            }
                            Spacer().frame(width: 8)
                        }
                        .background(user.user.userName == globalVM.currentUser?.userName ? .yellow.opacity(0.5) : .clear)
                        .clipShape(.rect(cornerRadius: 10))
                        .bold(user.user.userName == globalVM.currentUser?.userName)
                        .accessibilityElement(children: .ignore)
                        .accessibilityElement()
                        .accessibilityLabel(Strings.Community.Accessibility.ScoreboardRow(user.user.userName, user.points))
                        Divider()
                    }
                }
                
                if !scoreboard.scoreboardUsers.contains(where: { $0.user.userName == globalVM.currentUser?.userName }) {
                    Text(Strings.Community.Scoreboard.NoPointsYet)
                        .fontDesign(.rounded)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray)
            )
        }
        
        if !viewModel.appliedWins.isEmpty {
            winsView()
        }
    }
    
    @ViewBuilder
    private func winsView() -> some View {
        VStack {
            Text(Strings.Community.Rewards.CurrentRewards)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
            Text(Strings.Community.Rewards.CurrentRewardsDesc)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(viewModel.appliedWins, id: \.winId) { win in
                Spacer().frame(height: 12)
                Text("🎉 ") +
                Text(win.rewardType.getFriendlyName()) +
                Text(" 🎉")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray)
        )
    }
    
    private func userIsOutOfRange() -> Bool {
        guard let scoreboard = viewModel.scoreboard else { return false }
        
        var userIsOutOfRange = false
        if scoreboard.scoreboardUsers.count > 1 {
            let userPos = scoreboard.scoreboardUsers.firstIndex(where: { $0.user.userName == globalVM.currentUser?.userName })
            if let userPos, userPos > 0 {
                let prev = scoreboard.scoreboardUsers[userPos - 1].rank
                userIsOutOfRange = scoreboard.scoreboardUsers[userPos].rank != (prev + 1)
            }
        }
        
        return userIsOutOfRange
    }
}

#if DEBUG
#Preview {
    let global = GlobalViewModel()
    global.currentUser = PreviewUserData.Current
    return ScoreboardView(id: "9eed715de1c94746a30c4556b8e0e2a8")
        .padding(.horizontal, 16)
        .environment(global)
}
#endif
