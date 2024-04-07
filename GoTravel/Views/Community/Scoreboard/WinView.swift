//
//  WinView.swift
//  GoTravel
//
//  Created by Tom Knighton on 02/04/2024.
//

import SwiftUI
import Lottie
import GoTravel_Models
import GoTravel_API

public struct WinView: View {
    
    @Environment(GlobalViewModel.self) private var globalVM
    @State private var isLoading: Bool = false
    @State private var showSuccess: Bool = false
    @Environment(\.dismiss) private var dismiss
    public let win: ScoreboardWin
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            LottieView {
                try await DotLottieFile.named(Strings.Assets.Confetti)
            }
            .looping()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .accessibilityHidden()
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: { self.dismiss() }) {
                        ExitButtonView()
                    }
                    Spacer().frame(width: 16)
                }
                Spacer()
                Text(Strings.Misc.Congrats)
                    .font(.largeTitle.bold())
                Text(Strings.Community.Rewards.Placed1st)
                
                Text(Strings.Community.Rewards.SpinWheel)
                Spacer()
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.orange)
                        .shadow(radius: 3)
                        .bold()
                } else {
                    Button(action: { Task { await claimPrize() }}) {
                        Text(Strings.Community.Rewards.ClaimPrize)
                            .bold()
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                }
                
                Spacer()
                Spacer()
            }
        }
        .multilineTextAlignment(.center)
        .fontDesign(.rounded)
        .alert(win.rewardType == .noReward ? Strings.Misc.Results : Strings.Misc.Woohoo, isPresented: $showSuccess) {
            Button(action: { self.dismiss() }) { Text(Strings.Misc.Ok) }
        } message: {
            if win.rewardType == .noReward {
                Text(Strings.Community.Rewards.LostRaffle)
            } else {
                Text(Strings.Community.Rewards.YouveWon) + Text(win.rewardType.getFriendlyName())
            }
        }

    }
    
    private func claimPrize() async {
        self.isLoading = true
        defer { self.isLoading = false }
        
        guard let user = globalVM.currentUser else { return }
        do {
            let success = try await ScoreboardService.ClaimWin(for: user.userId, winId: win.winId)
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            self.showSuccess = success
        } catch {
            print(error)
        }
    }
}

#if DEBUG
#Preview {
    let global = GlobalViewModel()
    global.currentUser = PreviewUserData.Current
    return WinView(win: .init(winId: "", scoreboardName: "Most Travel", wonAt: Date(), position: 1, rewardType: .pointMultiplier2))
        .environment(global)
}
#endif
