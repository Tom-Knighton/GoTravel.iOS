//
//  ContentView.swift
//  GoTravel
//
//  Created by Tom Knighton on 25/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(GlobalViewModel.self) private var globalVM
    
    @State private var number: Int = 0
    
    var body: some View {
        @Bindable var globalVM = globalVM
        
        TabView(selection: $globalVM.tabIndex) {
            HomeMapPage()
                .tag(0)
                .tabItem {
                    Label(Strings.Navigation.MapTab, systemImage: Icons.map)
                }
        }
    }
}
