//
//  StopPointInfo.swift
//
//
//  Created by Tom Knighton on 21/01/2024.
//

import Foundation

/// Information about a stop point
public struct StopPointInfo: Decodable {
    
    /// Whether or not the stop has WiFi for customers
    public let hasWifi: Bool
    
    /// Information on any toilets available at this stop
    public let toiletsInfo: [StopPointToiletInfo]
    
    /// Information on the accessibility of the station
    public let accessibleInfo: StopPointAccessibleInfo?
    
    /// Information on the address of this station
    public let addressInfo: StopPointAddresInfo?
    
    public init(hasWifi: Bool, toiletsInfo: [StopPointToiletInfo], accessibleInfo: StopPointAccessibleInfo?, addressInfo: StopPointAddresInfo?) {
        self.hasWifi = hasWifi
        self.toiletsInfo = toiletsInfo
        self.accessibleInfo = accessibleInfo
        self.addressInfo = addressInfo
    }
}

/// Information on a type of bathroom available at a stop
public struct StopPointToiletInfo: Decodable {
    
    /// The type of bathroom: Men, Women or Unisex
    public let type: String
    
    /// If the bathroom is free to use
    public let free: Bool
    
    /// If the bathroom is accessible (disability stalls, accessible entrance etc.)
    public let accessible: Bool
    
    /// If the bathroom has a baby changing facility
    public let hasBabyGate: Bool

    /// Any other info on the bathroom
    public let info: String?
    
    public init(type: String, free: Bool, accessible: Bool, hasBabyGate: Bool, info: String?) {
        self.type = type
        self.free = free
        self.accessible = accessible
        self.hasBabyGate = hasBabyGate
        self.info = info
    }
}

/// Info on the stop's accessibility
public struct StopPointAccessibleInfo: Decodable {
    
    /// Whether it is accessible or not
    public let viaLift: Bool
    
    /// Any info on the accessibility of the stop. May be a note on a specific entrance to use etc.
    public let info: String?
    
    public init(viaLift: Bool, info: String?) {
        self.viaLift = viaLift
        self.info = info
    }
}

/// Info on the stop's address
public struct StopPointAddresInfo: Decodable {
    
    /// The phone number of the stop
    public let phone: String?
    
    /// The address of the stop
    public let address: String?
    
    public init(phone: String?, address: String?) {
        self.phone = phone
        self.address = address
    }
}
