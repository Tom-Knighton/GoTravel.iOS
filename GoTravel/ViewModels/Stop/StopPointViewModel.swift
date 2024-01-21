//
//  StopPointViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 16/01/2024.
//

import SwiftUI
import Observation
import GoTravel_Models
import GoTravel_API

@Observable
public class StopPointViewModel {
    
    //MARK: Stop Basic Data
    public var stopPoint: StopPoint?
    public var isLoading: Bool = true
    public var didLoadError: Bool = false
    
    //MARK: Stop Arrivals
    public var arrivalLines: [StopPointLineArrivals] = []
    public var arrivalsLastRefresh: Date?
    public var loadingArrivals: Bool = false
    
    
    public func load(_ stopId: String) async {
        self.isLoading = true
        
        do {
            let stop = try await StopPointService.Get(stopId, getHub: true)
            await MainActor.run {
                self.stopPoint = stop
                self.isLoading = false
                self.setupArrivalData()
            }
        }
        catch {
            self.isLoading = false
            self.didLoadError = true
            print("ERROR SETTING STOP PPINT")
        }
    }
    
    public func loadArrivals() async {
        
        guard !isLoading, !loadingArrivals, let stop = stopPoint?.stopPoint else {
            return
        }
        
        self.loadingArrivals = true
        
        // Shouldn't request if last request time was < 5 seconds ago, but fake it:
        if let last = self.arrivalsLastRefresh, last.timeUntil(Date(), unit: .seconds) < 5 {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            await MainActor.run {
                self.loadingArrivals = false
            }
            return
        }
        
        do {
            let arrivals = try await StopPointService.Arrivals(stop.stopPointId, includeChildrenAndHubs: true)
            await MainActor.run {
                arrivals.modeArrivals.forEach { mode in
                    mode.lineArrivals.forEach { line in
                        let existingLineIndex = self.arrivalLines.firstIndex(where: { $0.lineId == line.lineId })
                        if let existingLineIndex {
                            self.arrivalLines[existingLineIndex].platforms = line.platforms
                        }
                    }
                }
            }
        }
        catch {
            //TODO: Error message
            print("error setting arrivals " + error.localizedDescription)
        }
        
        await MainActor.run {
            self.arrivalsLastRefresh = Date()
            self.loadingArrivals = false
        }
    }
    
    public func hasBusLikeArrivals(for lineMode: String) -> Bool {
        
        let lineMode = self.stopPoint?.stopPoint.lineModes.first(where: { $0.lineModeName == lineMode })
        return lineMode?.hasFlag("Arrivals_IsBusLike") ?? false
    }
    
    
    private func setupArrivalData() {
        
        guard let stop = stopPoint?.stopPoint else {
            return
        }
        
        // Grab all the lines we *expect* to get arrivals for, this means lines will show up even when there are no arrivals (i.e. at night)
        
        let lineModesExpected = stop.lineModes.filter { !$0.hasFlag("Arrivals_DoNotShow") }
        let linesExpected = lineModesExpected
            .flatMap { mode in
                let lines = mode.lines
                return lines.compactMap { line in
                    return StopPointLineArrivals(lineMode: mode.lineModeName, lineId: line.lineId, lineName: line.lineName, platforms: [])
                }
            }
        
        self.arrivalLines = linesExpected
        
    }
}
