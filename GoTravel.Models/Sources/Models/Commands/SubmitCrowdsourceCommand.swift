//
//  SubmitCrowdsourceCommand.swift
//
//
//  Created by Tom Knighton on 08/03/2024.
//

import Foundation

public struct SubmitCrowdsourceCommand: Codable {
    
    public let freeText: String?
    public let isDelayed: Bool
    public let isClosed: Bool
    public let startsAt: Date
    public let endsAt: Date
    
    public init(freeText: String?, isDelayed: Bool, isClosed: Bool, startsAt: Date, endsAt: Date) {
        self.freeText = freeText
        self.isDelayed = isDelayed
        self.isClosed = isClosed
        self.startsAt = startsAt
        self.endsAt = endsAt
    }
}
