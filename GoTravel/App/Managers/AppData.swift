//
//  AppData.swift
//  GoTravel
//
//  Created by Tom Knighton on 07/11/2023.
//

import SwiftUI

@Observable
public class AppData {
    
    public static let shared = AppData()
    
    // MARK: Data
    class Data {
        @AppStorage("app_sessions") public var appSessions: Int = 0
        @AppStorage("hasUsedSearchAround") public var hasUsedSearchAround: Bool = false
    }
    
    private let data = Data()
    
    // MARK: Data Wrappers
    
    /// The number of times the app has been opened
    public var appSessions: Int {
        didSet {
            data.appSessions = appSessions
        }
    }
    
    /// If the user has tapped the 'search here' button on the map page
    public var hasUsedSearchAround: Bool {
        didSet {
            data.hasUsedSearchAround = hasUsedSearchAround
        }
    }
    
    
    // MARK: Init
    public init() {
        self.appSessions = data.appSessions
        self.hasUsedSearchAround = data.hasUsedSearchAround
    }
}
