//
//  BikeStopPoint.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation

/// A stop point where bikes are retrieved from/parked
public class BikeStopPoint: StopPointBase {
    
    /// The number of bikes free at this stop point
    public let bikesRemaining: Int
    
    /// The number of electronic bikes free at this stop point
    public let eBikesRemaining: Int
    
    enum CodingKeys: String, CodingKey {
        case bikesRemaining, eBikesRemaining
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bikesRemaining = try container.decode(Int.self, forKey: .bikesRemaining)
        self.eBikesRemaining = try container.decode(Int.self, forKey: .eBikesRemaining)
        
        try super.init(from: decoder)
    }
}
