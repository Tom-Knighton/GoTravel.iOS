//
//  GoLondonApp.swift
//  GoLondon
//
//  Created by Tom Knighton on 25/09/2023.
//

import SwiftUI

@main
struct GoLondonApp: App {
    
    @State private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(locationManager)
                .task {
                    if self.locationManager.locationUndetermined {
                        locationManager.requestAuth()
                    }
                 }
        }
    }
}
