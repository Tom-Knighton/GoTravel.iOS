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
    
}
