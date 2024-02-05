//
//  JourneyRequest.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation

/// A request to plan a journey
public struct JourneyRequest: Codable {
    
    /// The location the journey should start from
    public let startPoint: JourneyRequestLocation
    
    /// The location the journey should end at
    public let endPoint: JourneyRequestLocation
    
    /// The location the journey should pass through, optionally
    public let viaLocation: JourneyRequestLocation?
    
    /// The time the journey should arrive/depart at. If nil, `now()` is assumed by the API
    public let journeyTime: Date?
    
    /// Whether the `journeyTime` is the time the journey should leave at, or if false, arrive at. This has no effect if `journeyTime` is `nil`
    public let journeyTimeIsDeparture: Bool
    
    /// The preference mode for this journey search
    public let preferenceMode: JourneyRequestPreferenceMode?
    
    /// Any accessibility preferences that should be taken into account when planning the journey
    public let accessibilityPreferences: [JourneyRequestAccessibilityPreference]?
    
    public init(startPoint: JourneyRequestLocation, endPoint: JourneyRequestLocation, viaLocation: JourneyRequestLocation?, journeyTime: Date?, journeyTimeIsDeparture: Bool, preferenceMode: JourneyRequestPreferenceMode?, accessibilityPreferences: [JourneyRequestAccessibilityPreference]?) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.viaLocation = viaLocation
        self.journeyTime = journeyTime
        self.journeyTimeIsDeparture = journeyTimeIsDeparture
        self.preferenceMode = preferenceMode
        self.accessibilityPreferences = accessibilityPreferences
    }
}
