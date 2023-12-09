//
//  LineModeService.swift
//  GoTravel
//
//  Created by Tom Knighton on 05/12/2023.
//

import Foundation
import GoTravel_Models

public struct LineModeService {
    
    static let client = APIClient()
    
    /// Returns line modes grouped by areas. Optionall will sort the current 'location' area first
    /// - Parameters:
    ///   - lat: Optional, the latitude of the user, covering area will be returned first
    ///   - lon: Optional, the latitude of the user, covering area will be returned first
    public static func GetAllLineModes(lat: Double?, lon: Double?) async throws -> [LineModeGroup] {
        
        var queryItems: [URLQueryItem] = []
        if let lat, let lon {
            queryItems.append(.init(name: "lat", value: "\(lat)"))
            queryItems.append(.init(name: "lon", value: "\(lon)"))
        }
        
        let request = APIRequest(path: "LineModes", queryItems: queryItems, body: nil)
        let result: [LineModeGroup] = try await client.perform(request)
        
        return result
    }
    
    
    /// Returns the area name from a set of coordinates. May default to 'UK' if no other area found.
    /// - Parameters:
    ///   - lat: The latitude of the search point
    ///   - lon: The longitude of the search point
    public static func GetArea(lat: Double, lon: Double) async throws -> String {
     
        let request = APIRequest(path: "LineModes/AreaFromCoordinates/\(lat)/\(lon)", queryItems: [], body: nil)
        let result: String = try await client.perform(request)
        
        return result
    }
}
