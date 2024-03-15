//
//  ReportCrowdsourceCommand.swift
//
//
//  Created by Tom Knighton on 13/03/2024.
//

import Foundation

public struct ReportCrowdsourceCommand: Codable {
    
    public let reportReason: String
    
    public init(reportReason: String) {
        self.reportReason = reportReason
    }
}
