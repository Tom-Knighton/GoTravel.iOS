//
//  SubmitCrowdsourceViewModel.swift
//  GoTravel
//
//  Created by Tom Knighton on 09/03/2024.
//

import Foundation
import Observation
import GoTravel_Models
import GoTravel_API

@Observable
public class SubmitCrowdsourceViewModel {
    public enum Status: Int {
        case noChange = 0
        case delayed = 1
        case closed = 2
    }
    
    public var journeyStatus: Status = .noChange
    public var freeText: String = ""
    public let freeTextLimit: Int = 128
    
    public var startsAt: Date = Date()
    public var endsAt: Date = Date()
    
    public var isLoading: Bool = false
    public var error: String? = nil
    public var showError: Bool = false
    
    public init() {
        if let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) {
            self.endsAt = tomorrow
        } else {
            self.endsAt = Date().addingTimeInterval(60 * 60 * 24)
        }
    }
    
    public func submit(for entityId: String) async -> Bool {
        self.error = nil
        self.isLoading = true
        defer { self.isLoading = false }
        
        if self.journeyStatus == .noChange && self.freeText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.error = "If there's no change to the journey status, you need to provide some text telling other user's what's happening! If you're trying to balance out reports of delays/closed stops - simply report those submissions instead."
        }
        
        if self.freeText.trimmingCharacters(in: .whitespacesAndNewlines).count > freeTextLimit {
            self.error = "Your status text is too long"
        }
        
        if self.startsAt.timeUntil(self.endsAt, unit: .hours) < 5 {
            self.error = "This information might not be right for other users - there should be a minimum of 5 hours for an event, otherwise it probably won't impact others!"
        }
        
        if self.error != nil {
            self.showError = true
            return false
        }
        
        let submission = CrowdsourceSubmission(crowdsourceId: "", text: self.freeText.trimmingCharacters(in: .whitespacesAndNewlines), isDelayed: self.journeyStatus == .delayed, isClosed: self.journeyStatus == .closed, started: self.startsAt, expectedEnd: self.endsAt, isFlagged: false, submittedBy: nil, currentUserVoteStatus: .noVote, score: 0)
        
        do {
            let success = try await CrowdsourceService.Submit(for: entityId, submission: submission)
            return success
        } catch {
            self.error = "Something went wrong uploading your submission. It may have failed our automatic moderation - make sure any text provided is relevant for other users and not harmful."
            self.showError = true
            print(error)
            return false
        }
    }
}
