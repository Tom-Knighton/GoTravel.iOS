//
//  CrowdsourceService.swift
//
//
//  Created by Tom Knighton on 08/03/2024.
//

import Foundation
import GoTravel_Models

public struct CrowdsourceService {
    
    private static let api = APIClient()
    
    
    /// Returns crowdsource submissions for an entity, like a line or stop
    /// - Parameter entity: The id of the entity to retrieve info for, i.e. a line id or stop id
    public static func GetSubmissions(for entity: String) async throws -> [CrowdsourceSubmission] {
        
        let request = APIRequest(path: "Crowdsource/Entity/\(entity)", queryItems: [], body: nil)
        let response: [CrowdsourceSubmission] = try await api.perform(request)
        
        return response
    }
    
    
    /// Submits a crowdsource submission for an entity
    /// - Parameters:
    ///   - entity: The id of the entity to submit for, i.e. a line id or a stop id
    ///   - submission: The details of the submission, the 'id' does not have to be filled in
    /// - Throws:
    ///    - If throws 400, either text is too long or did not pass moderation, the error message will contain details
    public static func Submit(for entity: String, submission: CrowdsourceSubmission) async throws -> Bool {
        
        let command = SubmitCrowdsourceCommand(freeText: submission.text, isDelayed: submission.isDelayed, isClosed: submission.isClosed, startsAt: submission.started, endsAt: submission.expectedEnd)
        let request = APIRequest(method: .post, path: "Crowdsource/Entity/\(entity)", queryItems: [], body: nil)
        let _ = try await api.performExpect200(request)
        
        return true
    }
    
}
