//
//  APIClient.swift
//  GoTravel
//
//  Created by Tom Knighton on 07/10/2023.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case head = "HEAD"
    case connect = "CONNECT"
}

public struct APIRequest {
    var method: HttpMethod = .get
    let path: String
    let queryItems: [URLQueryItem]?
    let body: Data?
    var contentType: String = "application/json"
    var idempotencyKey: String? = nil
}

public actor APIClient {
    
    private let session = URLSession.shared
        
    private let baseUrl = URL(string: (Bundle.main.object(forInfoDictionaryKey: "GTAPI_BASE_URL") as? String ?? "https://api.gotravel.tomk.online"))
        
    func perform<T: Decodable>(_ request: APIRequest) async throws -> T {
        let (data, _) = try await perform(request)
      
        if T.self is String.Type {
            return String(data: data, encoding: .utf8) as! T
        }
        
        do {
            let response = try! data.decode(to: T.self)
            return response
        } catch {
            throw error
        }
    }
    
    func performExpect200(_ request: APIRequest) async throws {
        let (_, resp) = try await perform(request)
        
        if let resp = resp as? HTTPURLResponse {
            if (200...299).contains(resp.statusCode) {
                return
            }
        }
        
        throw APIError.unexpectedFailure
    }
    
    private func perform(_ request: APIRequest) async throws -> (Data, URLResponse) {
        guard let baseUrl else {
            throw APIError.invalidBaseUrl
        }
        
        let url = baseUrl.appending(path: request.path).appending(queryItems: request.queryItems ?? [])
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = request.method.rawValue
        apiRequest.setValue(request.contentType, forHTTPHeaderField: "Content-Type")
        
        if let idempotencyKey = request.idempotencyKey {
            apiRequest.setValue(idempotencyKey, forHTTPHeaderField: "IdempotencyKey")
        }
        
        if let token = try? await AuthClient.GetToken() {
            apiRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            print(token)
        }
        
        #if DEBUG
        print(apiRequest.allHTTPHeaderFields)
        print(url.absoluteString)
        #endif
        
        if let body = request.body {
            apiRequest.httpBody = body
        }
        
        let (data, resp) = try await session.data(for: apiRequest)
        
        return (data, resp)
    }
}
