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
    public var journeyResult: JourneyOptionsResult? = nil
    
    /// Swaps the stops in From/To, even if they are empty
    func swapStops() {
        let oldFrom = self.from
        let oldTo = self.to
        
        self.from = oldTo
        self.to = oldFrom
    }
    
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
    
    /// If preconditions are met, plan a journey and store results in `journeyResult`
    func planJourney() async {
        guard let from, let to else {
            return
        }
        
        self.isSearchingJourneys = true
        
        let startPoint = JourneyRequestLocation(coordinate: from.coordinate)
        let endPoint = JourneyRequestLocation(coordinate: to.coordinate)
        var viaPoint: JourneyRequestLocation? = nil
        if let via {
            viaPoint = JourneyRequestLocation(coordinate: via.coordinate)
        }
        
        var time: Date? = nil
        var timeIsDeparture = false
        switch self.journeyTime {
        case .arriveAt(let date):
            time = date
        case .leaveAt(let date):
            time = date
            timeIsDeparture = true
        default:
            time = nil
        }
    
        
        do {
            let request = JourneyRequest(startPoint: startPoint, endPoint: endPoint, viaLocation: viaPoint, journeyTime: time, journeyTimeIsDeparture: timeIsDeparture, preferenceMode: nil, accessibilityPreferences: nil)
            let response = try await JourneyService.JourneyOptions(request)
            await MainActor.run {
                self.journeyResult = response
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
        
        
        self.isSearchingJourneys = false
    }
}
