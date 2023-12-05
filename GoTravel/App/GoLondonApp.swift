//
//  GoTravelApp.swift
//  GoTravel
//
//  Created by Tom Knighton on 25/09/2023.
//

import SwiftUI
import TipKit

@main
struct GoTravelApp: App {
    
    @State private var globalVM = GlobalViewModel.shared
    @State private var locationManager = LocationManager()
    @State private var appData = AppData.shared
    
    
    init() {
//        try? Tips.resetDatastore()
        try? Tips.configure()

        
        appData.appSessions += 1
        print(appData.appSessions)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(globalVM)
                .environment(locationManager)
                .environment(appData)
                .task {
                    if self.locationManager.locationUndetermined {
                        locationManager.requestAuth()
                    }
                 }
        }
    }
}
