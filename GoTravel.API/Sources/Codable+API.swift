//
//  Codable+API.swift
//  GoTravel
//
//  Created by Tom Knighton on 07/10/2023.
//

import Foundation

extension Encodable {
    
    /// Encodes the model to it's Data representation, useful for sending API requests
    func toJson() -> Data? {
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        encoder.dateEncodingStrategy = .formatted(formatter)
        let encoded = try? encoder.encode(self)
        return encoded
    }
}

public extension Data {
    func decode<T: Decodable>(to type: T.Type, dateFormat: String? = "yyyy-MM-dd'T'HH:mm:ss'Z'") throws -> T {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat ?? "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(formatter)
        let decoded = try decoder.decode(T.self, from: self)
        return decoded
    }
}
