//
//  JourneyRequestTime.swift
//
//
//  Created by Tom Knighton on 31/01/2024.
//

import Foundation

public enum JourneyRequestTime {
    case now
    case leaveAt(Date)
    case arriveAt(Date)
}
