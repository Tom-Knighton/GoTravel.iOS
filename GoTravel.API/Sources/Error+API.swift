//
//  Error+API.swift
//  GoTravel
//
//  Created by Tom Knighton on 07/10/2023.
//

import Foundation

enum APIError: Error {
    case invalidBaseUrl
    case couldNotParse
    case unexpectedFailure
}
