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
    public var from: String = ""
    public var to: String = ""
    public var via: String = ""
    public var showViaField: Bool = false
    
    //MARK: Search Sheet
    public var isSearching: Bool = false
    public var searchResults: [StopPoint] = []
    
    
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


public enum JourneyPlannerSearchSheetType: Int, Identifiable {
    case from = 0
    case to = 1
    case via = 2
    
    public var id: Self {
        return self
    }
}

