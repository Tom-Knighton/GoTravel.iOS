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
}

public actor APIClient {
    
    private let session = URLSession.shared
        
    private let baseUrl = URL(string: (Bundle.main.object(forInfoDictionaryKey: "GTAPI_BASE_URL") as? String ?? "https://api.gotravel.tomk.online"))
        
    func perform<T: Decodable>(_ request: APIRequest) async throws -> T {
        guard let baseUrl else {
            throw APIError.invalidBaseUrl
        }
        
        let url = baseUrl.appending(path: request.path).appending(queryItems: request.queryItems ?? [])
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = request.method.rawValue
        apiRequest.setValue(request.contentType, forHTTPHeaderField: "Content-Type")
        
        if let token = try? await AuthClient.GetToken() {
            apiRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            print(token)
        }
        
        #if DEBUG
        print(url.absoluteString)
        #endif
        
        if let body = request.body {
            apiRequest.httpBody = body
        }
        
        let (data, _) = try await session.data(for: apiRequest)
        
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
}
