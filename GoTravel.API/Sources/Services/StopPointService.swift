//
//  StopPointService.swift
//  GoTravel
//
//  Created by Tom Knighton on 07/10/2023.
//

import Foundation
import GoTravel_Models

public struct StopPointService {
    
    static let client = APIClient()
    
    
    /// Returns Stop Points around a specified location
    /// - Parameters:
    ///   - lat: The decimal latitude of the search position
    ///   - lon: The decimal longitude of the search position
    ///   - radius: The radius in metres to search around the search position
    ///   - maxResults: The max number of results to return
    public static func SearchAround(lat: Double, lon: Double, radius: Int = 850, maxResults: Int = 25) async throws -> [StopPoint] {
        
        let queryItems: [URLQueryItem] = [.init(name: "radius", value: "\(radius)"), .init(name: "maxResults", value: "\(maxResults)")]
        let request = APIRequest(path: "StopPoint/Search/Around/\(lat)/\(lon)", queryItems: queryItems, body: nil)
        let result: [StopPoint] = try await client.perform(request)
        
        return result
    }
}
