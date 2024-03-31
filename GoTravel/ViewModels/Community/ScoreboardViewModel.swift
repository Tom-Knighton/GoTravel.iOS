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
    
    public func load(_ id: String) async {
        do {
            self.scoreboard = try await ScoreboardService.GetScoreboard(by: id)
        } catch {
            print(error)
            self.isError = true
        }
    }
}
