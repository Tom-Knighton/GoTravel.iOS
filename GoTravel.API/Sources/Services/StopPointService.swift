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
    public static func SearchAround(lat: Double, lon: Double, radius: Int = 850, maxResults: Int = 25, hiddenLineModes: [String]? = nil) async throws -> [StopPoint] {
        
        var queryItems: [URLQueryItem] = [.init(name: "radius", value: "\(radius)"), .init(name: "maxResults", value: "\(maxResults)")]
        
        if let hiddenLineModes {
            hiddenLineModes.forEach { queryItems.append(.init(name: "hiddenLineModes", value: $0)) }
        }
        
        let request = APIRequest(path: "StopPoint/Search/Around/\(lat)/\(lon)", queryItems: queryItems, body: nil)
        let result: [StopPoint] = try await client.perform(request)
        
        return result
    }
    
    /// Returns Stop Points with names or codes similar to a search query
    /// - Parameters:
    ///   - query: The query to search for. Performs a 'LIKE %{query}%' style operation, so no regex required
    ///   - maxResults: The max number of results to return
    ///   - hiddenLineModes: Any line modes that should not be returned in results
    public static func Search(_ query: String, maxResults: Int = 25, hiddenLineModes: [String]? = nil) async throws -> [StopPoint] {
        var queryItems: [URLQueryItem] = [.init(name: "maxResults", value: "\(maxResults)")]
        
        if let hiddenLineModes {
            hiddenLineModes.forEach { queryItems.append(.init(name: "hiddenLineModes", value: $0)) }
        }
        
        let request = APIRequest(path: "StopPoint/Search/\(query)", queryItems: queryItems, body: nil)
        let result: [StopPoint] = try await client.perform(request)
        
        return result
    }
    
    
    /// Returns the stop point by it's id or hub id
    /// - Parameters:
    ///   - id: The id of the stop point
    ///   - getHub: Whether or not to return the hub or not
    public static func Get(_ id: String, getHub: Bool = false) async throws -> StopPoint {
        let request = APIRequest(path: "StopPoint/\(id)", queryItems: [], body: nil)
        let result: StopPoint = try await client.perform(request)
        
        return result
    }
    
    /// Returns upcoming arrivals/departures for a specified stop
    /// - Parameters:
    ///   - id: The id of the stop point to get arrivals for
    ///   - includeChildrenAndHubs: Whether or not to include arrivals for the entire HUB the stop belongs to, as well as children of this stop
    public static func Arrivals(_ id: String, includeChildrenAndHubs: Bool = false) async throws -> StopPointArrivals {
        var queryItems: [URLQueryItem] = []
        queryItems.append(.init(name: "includeChildrenAndHubs", value: includeChildrenAndHubs ? "true" : "false"))

        
        let request = APIRequest(path: "StopPoint/\(id)/Arrivals", queryItems: queryItems, body: nil)
        let result: StopPointArrivals = try await client.perform(request)
        
        return result
    }
    
    /// Returns info on the specific stop
    /// - Parameters:
    ///   - id: The id of the stop to get info for
    ///   - useParentOrHub: Whether or not to use the stop's parent or hub to collect info
    public static func Info(_ id: String, useParentOrHub: Bool = false) async throws -> StopPointInfo {
        var queryItems: [URLQueryItem] = []
        queryItems.append(.init(name: "useParentOrHub", value: useParentOrHub ? "true" : "false"))

        
        let request = APIRequest(path: "StopPoint/\(id)/Info", queryItems: queryItems, body: nil)
        let result: StopPointInfo = try await client.perform(request)
        
        return result
    }
}
