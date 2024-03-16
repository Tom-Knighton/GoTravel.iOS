//
//  VoteCrowdsourceCommand.swift
//
//
//  Created by Tom Knighton on 13/03/2024.
//

import Foundation

public struct VoteCrowdsourceCommand: Codable {
    
    public let voteType: CrowdsourceVoteStatus
    
    public init(voteType: CrowdsourceVoteStatus) {
        self.voteType = voteType
    }
}
