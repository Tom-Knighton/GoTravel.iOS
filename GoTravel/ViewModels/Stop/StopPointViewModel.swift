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
    
    public var stopPoint: StopPoint?
    public var isLoading: Bool = true
    public var didLoadError: Bool = false
    
    public func load(_ stopId: String) async {
        self.isLoading = true
        
        do {
            self.stopPoint = try await StopPointService.Get(stopId, getHub: true)
            self.isLoading = false
        }
        catch {
            self.isLoading = false
            self.didLoadError = true
        }
    }
}
