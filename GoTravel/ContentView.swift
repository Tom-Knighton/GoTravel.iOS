//
//  ContentView.swift
//  GoTravel
//
//  Created by Tom Knighton on 25/09/2023.
//

import SwiftUI
import GoTravel_Models
import SwiftData

struct ContentView: View {
    
    @Environment(GlobalViewModel.self) private var globalVM
    @Environment(JourneyManager.self) private var journeyManager
    
    @State private var isInJourney: Bool = false
    
    var body: some View {
        @Bindable var globalVM = globalVM
        
        ZStack {
            TabView(selection: $globalVM.tabIndex) {
                NavigationStack(path: $globalVM.mapPath) {
                    HomeMapPage()
                        .navigationDestination(for: StopPointNavModel.self) { nav in
                            StopPointPage(stopId: nav.stopPointId)
                        }
                        .navigationDestination(for: QuickJourneyNavModel.self) { nav in
                            JourneyPlannerPage(preSetDestination: nav.destination)
                        }
                        .navigationDestination(for: JourneyDetailNavModel.self) { nav in
                            JourneyDetailPage(nav.journey)
                        }
                        .navigationDestination(for: SavedJourneyNavModel.self) { nav in
                            SavedJourneyView(id: nav.savedJourneyId)
                        }
                }
                .tag(0)
                .tabItem {
                    Label(Strings.Navigation.MapTab, systemImage: Icons.map)
                }
                
                NavigationStack(path: $globalVM.journeyPath) {
                    JourneyPlannerPage()
                        .navigationDestination(for: StopPointNavModel.self) { nav in
                            StopPointPage(stopId: nav.stopPointId)
                        }
                        .navigationDestination(for: QuickJourneyNavModel.self) { nav in
                            JourneyPlannerPage(preSetDestination: nav.destination)
                        }
                        .navigationDestination(for: JourneyDetailNavModel.self) { nav in
                            JourneyDetailPage(nav.journey)
                        }
                        .navigationDestination(for: SavedJourneyNavModel.self) { nav in
                            SavedJourneyView(id: nav.savedJourneyId)
                        }
                }
                .tag(1)
                .tabItem {
                    Label(Strings.Navigation.JourneyTab, systemImage: Icons.signPostFilled)
                }
                
                NavigationStack(path: $globalVM.communityPath) {
                    CommunityPage()
                        .navigationDestination(for: StopPointNavModel.self) { nav in
                            StopPointPage(stopId: nav.stopPointId)
                        }
                        .navigationDestination(for: QuickJourneyNavModel.self) { nav in
                            JourneyPlannerPage(preSetDestination: nav.destination)
                        }
                        .navigationDestination(for: JourneyDetailNavModel.self) { nav in
                            JourneyDetailPage(nav.journey)
                        }
                        .navigationDestination(for: SavedJourneyNavModel.self) { nav in
                            SavedJourneyView(id: nav.savedJourneyId)
                        }
                }
                .tag(2)
                .tabItem {
                    Label(Strings.Navigation.CommunityTab, systemImage: Icons.personOnBustFilled)
                }
            }
            
            if (isInJourney) {
                VStack {
                    TrackingJourneyView(onDismiss: {
                        withAnimation {
                            self.isInJourney = false
                        }
                    })
                    .transition(.move(edge: .top))
                    Spacer()
                }
            }
        }
        .task {
            journeyManager.current = await journeyManager.currentJourney()
        }
        .onChange(of: journeyManager.current) { _, newValue in
            self.isInJourney = newValue != nil
        }
    }
}
