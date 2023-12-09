//
//  BusStopPoint.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation

/// Represents a stop point at which buses stop
public class BusStopPoint: StopPointBase {
     
    /// The 'letter' of the bus stop i.e. 'A', 'X', etc, may not be present
    public let busStopLetter: String?
    
    /// Usually some kind of indicator if the bus stop has no letter, i.e. '-> W' for a westbound stop
    public let busStopIndicator: String?
    
    /// The SMS code people can text to retrieve info for this bus stop
    public let busStopSMSCode: String?
    
    enum CodingKeys: String, CodingKey {
        case busStopLetter, busStopIndicator, busStopSMSCode
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.busStopLetter = try? container.decode(String.self, forKey: .busStopLetter)
        self.busStopIndicator = try? container.decode(String.self, forKey: .busStopIndicator)
        self.busStopSMSCode = try? container.decode(String.self, forKey: .busStopSMSCode)
        
        if busStopLetter == nil && busStopIndicator == nil && busStopSMSCode == nil {
            throw DecodingError.typeMismatch(BusStopPoint.self, .init(codingPath: [CodingKeys.busStopLetter, CodingKeys.busStopIndicator, CodingKeys.busStopSMSCode], debugDescription: "All bus values nil, not a bus stop"))
        }
        
        try super.init(from: decoder)
    }
}
