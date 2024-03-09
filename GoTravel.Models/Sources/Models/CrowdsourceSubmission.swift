//
//  CrowdsourceSubmission.swift
//
//
//  Created by Tom Knighton on 08/03/2024.
//

import Foundation

public struct CrowdsourceSubmission: Codable {
    
    public let crowdsourceId: String
    public let text: String?
    public let isDelayed: Bool
    public let isClosed: Bool
    public let started: Date
    public let expectedEnd: Date
    public let isFlagged: Bool
    public let submittedBy: User?
    public let currentUserVoteStatus: CrowdsourceVoteStatus
    public let score: Int
    
    public init(crowdsourceId: String, text: String?, isDelayed: Bool, isClosed: Bool, started: Date, expectedEnd: Date, isFlagged: Bool, submittedBy: User?, currentUserVoteStatus: CrowdsourceVoteStatus, score: Int) {
        self.crowdsourceId = crowdsourceId
        self.text = text
        self.isDelayed = isDelayed
        self.isClosed = isClosed
        self.started = started
        self.expectedEnd = expectedEnd
        self.isFlagged = isFlagged
        self.submittedBy = submittedBy
        self.currentUserVoteStatus = currentUserVoteStatus
        self.score = score
    }
}

public enum CrowdsourceVoteStatus: String, Codable {
    case upvoted = "Upvoted"
    case downvoted = "Downvoted"
    case noVote = "NoVote"
}
