//
//  CommunityViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 31/03/2024.
//

import SwiftUI
import Observation
import GoTravel_API

@Observable
public class CommunityViewModel {
    
    var mostTravelScoreboardId: String?
    
    private let mostTravelName = "Most Travel"
    
    public func loadMostTravelScoreboardId() async {
        guard let user = GlobalViewModel.shared.currentUser else { return }
        
        do {
            let scoreboards = try await ScoreboardService.GetScoreboards(for: user.userId)
            let id = scoreboards.first(where: { $0.scoreboardName == mostTravelName })?.scoreboardId
            mostTravelScoreboardId = id
        } catch {
            print(error)
        }
    }
}
