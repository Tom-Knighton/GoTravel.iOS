//
//  ScoreboardViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 31/03/2024.
//

import SwiftUI
import Observation
import GoTravel_Models
import GoTravel_API

@Observable
public class ScoreboardViewModel {
    
    public var isLoading: Bool = false
    public var scoreboard: Scoreboard? = nil
    public var isError: Bool = false
    
    public var appliedWins: [ScoreboardWin] = []
    
    public func load(_ id: String) async {
        do {
            self.scoreboard = try await ScoreboardService.GetScoreboard(by: id)
            if let userId = GlobalViewModel.shared.currentUser?.userId {
                let wins = try await ScoreboardService.ClaimedWins(for: userId)
                self.appliedWins = wins.filter { $0.rewardType != .noReward }
            }
        } catch {
            print(error)
            self.isError = true
        }
    }
}
