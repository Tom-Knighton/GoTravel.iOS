//
//  JourneyService.swift
//
//
//  Created by Tom Knighton on 02/02/2024.
//

import Foundation
import GoTravel_Models

public struct JourneyService {
    
    static let client = APIClient()

    
    /// Makes a journey request to the API and returns a list of possible journeys
    /// - Parameter request: The request details, including start and end points
    /// - Returns: A list of journey options, and a separate list of line modes and lines the journey options include taking
    public static func JourneyOptions(_ request: JourneyRequest) async throws -> JourneyOptionsResult {
        
        let request = APIRequest(method: .post, path: "Journey", queryItems: [], body: request.toJson())
        let result: JourneyOptionsResult = try await client.perform(request)
        
        return result
    }
    
    /// Saves a user's trip to the API to receive points
    /// - Parameter command: The trip details
    /// - Parameter id: An idempotency key, this should be the id of the SwiftData model ideally
    public static func SaveTrip(_ command: SaveUserTripCommand, id: String) async throws -> UserSavedJourney {
        
        let request = APIRequest(method: .post, path: "Journey/SaveTrip", queryItems: [], body: command.toJson())
        let result: UserSavedJourney = try await client.perform(request)
        
        return result
    }
    
    /// Returns all user's saved journeys
    public static func GetTrips(startFrom: Int = 1, results: Int = 25) async throws -> [UserSavedJourney] {
        
        let request = APIRequest(path: "Journey/Trips", queryItems: [.init(name: "startFrom", value: "\(startFrom)"), .init(name: "results", value: "\(results)")], body: nil)
        let result: [UserSavedJourney] = try await client.perform(request)
        
        return result
    }
    
}
