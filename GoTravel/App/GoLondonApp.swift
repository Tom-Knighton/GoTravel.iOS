//
//  GoTravelApp.swift
//  GoTravel
//
//  Created by Tom Knighton on 25/09/2023.
//

import SwiftUI
import TipKit
import SwiftData
import GoTravel_CoreData
import GoTravel_API

@main
struct GoTravelApp: App {
    
    @State private var globalVM = GlobalViewModel.shared
    @State private var locationManager = LocationManager()
    @State private var journeyManager = JourneyManager()
    @State private var appData = AppData.shared
    
    init() {
        try? Tips.resetDatastore()
        try? Tips.configure()

        
        appData.appSessions += 1
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        Task {
            let user = try? await UserService.CurrentUser()
            GlobalViewModel.shared.currentUser = user
            if let user {
                let wins = try? await ScoreboardService.UnseenWins(for: user.userId)
                if let win = wins?.first {
                    GlobalViewModel.shared.win = win
                }
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(globalVM)
                .environment(locationManager)
                .environment(appData)
                .environment(journeyManager)
                .task {
                    if self.locationManager.locationUndetermined {
                        locationManager.requestAuth()
                    }
                 }
        }
        .modelContainer(GoTravelCoreData.shared.container)
    }
}
