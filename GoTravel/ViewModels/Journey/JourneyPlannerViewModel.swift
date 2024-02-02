//
//  JourneyPlannerViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 30/01/2024.
//

import SwiftUI
import GoTravel_Models
import GoTravel_API

@Observable
public class JourneyPlannerViewModel {
    
    // MARK: Journey details
    public var from: JourneyRequestPoint? = nil
    public var to: JourneyRequestPoint? = nil
    public var via: JourneyRequestPoint? = nil
    public var showViaField: Bool = false
    public var journeyTime: JourneyRequestTime = .now
    
    //MARK: Search Sheet
    public var isSearching: Bool = false
    public var searchResults: [StopPoint] = []
    
    //MARK: Journeys
    public var isSearchingJourneys: Bool = false
    public var journeyOptions: [Journey] = []
    
    
    /// Performs a search for stops based on an input query and fills `searchResults` with the results
    func searchStops(_ search: String) async {
        
        if search.count == 0 {
            self.searchResults = []
            return
        }
        
        guard search.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3 else {
            return
        }
        
        isSearching = true
        let results = try? await StopPointService.Search(search.trimmingCharacters(in: .whitespacesAndNewlines), maxResults: 10)
        await MainActor.run {
            self.searchResults = results?.reversed() ?? []
            self.isSearching = false
        }
    }
}
