//
//  JourneyRequestAccessibilityPreference.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation

/// An accessibility preference that should be taken into account when making a journey - this may not always be respected in results if it isn't possible
public enum JourneyRequestAccessibilityPreference: String, Codable {
    
    /// A journey should not take a person up or down any physical stairs
    case noStairs = "NoStairs"
    
    /// A journey should not take a person up or down any escalators
    case noEscalators = "NoEscalators"
    
    /// A journey should not involve taking an elevator
    case noElevators = "NoElevators"
    
    /// A journey should shoud allow a person to make it to the vehicle (bus, train) without any steps (i.e. for wheelchair users)
    case stepFreeVehicle = "StepFreeToVehicle"
    
    /// A journey should allow a person to make it to the platform, but not necessarily the vehicle, without any steps (i.e. for wheelchair users)
    case stepFreePlatform = "StepFreeToPlatform"
}
