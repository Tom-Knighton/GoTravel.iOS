//
//  CommunityNotLoggedInView.swift
//  GoTravel
//
//  Created by Tom Knighton on 18/02/2024.
//

import SwiftUI
import Charts

public struct CommunityNotLoggedInView: View {
    
    @Environment(GlobalViewModel.self) private var globalVm
    @State private var showLoginSection: Bool = false
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("Join the Go Travel Community")
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Compete with friends and travellers across the UK to use the most public transport!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    CompetePanel()
                    TrackPanel()
                    SpecialChallengesPanel()
                    
                    Spacer()
                    
                    Button(action: { self.showLoginSection = true }) {
                        Text("Start Now")
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer().frame(height: 16)
                }
            }
            .fontDesign(.rounded)
            .contentMargins(.horizontal, 16, for: .scrollContent)
        }
        .sheet(isPresented: $showLoginSection, content: {
            NavigationStack {
                AuthPage()
            }
        })
        .onChange(of: globalVm.currentUser) { oldValue, newValue in
            if let newValue {
                self.showLoginSection = false
            }
        }
    }
    
    @ViewBuilder
    private func CompetePanel() -> some View {
        VStack {
            Text("Compete")
                .font(.headline.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Climb up the leaderboards and earn virtual points and prizes simply by travelling")
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            VStack {
                HStack {
                    Image("BlankProfile1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .clipShape(.circle)
                        .shadow(radius: 3)
                    Text("David_1988")
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Spacer()
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(.yellow)
                        .bold()
                    Text("300 pts")
                }
                Divider()
                HStack {
                    Image("BlankProfile3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .clipShape(.circle)
                        .shadow(radius: 3)
                    Text("You!")
                        .bold()
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Spacer()
                    Text("290 pts")
                }
                Divider()
                HStack {
                    Image("BlankProfile2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .clipShape(.circle)
                        .shadow(radius: 3)
                    Text("TrailBlazer01!")
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Spacer()
                    Text("207 pts")
                }
            }
            .padding(8)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.7), lineWidth: 1)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(Color.layer2)
        .clipShape(.rect(cornerRadius: 10))
        .padding(.vertical, 8)
        .shadow(radius: 3)
    }
    
    @ViewBuilder
    private func TrackPanel() -> some View {
        VStack {
            VStack {
                Text("Track")
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Track your journeys, and set travel goals to increase your public transport usage.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
 
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color.layer2)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 3)
        }
    }
    
    @ViewBuilder
    private func SpecialChallengesPanel() -> some View {
        VStack {
            VStack {
                Text("Special Challenges")
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Join the entire Go Travel community in special, time sensitive challenges across the UK")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
 
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color.layer2)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.vertical, 8)
            .shadow(radius: 3)
        }
    }
}

#Preview(body: {
    
    NavigationStack {
        CommunityNotLoggedInView()
            .navigationTitle("Community")
    }
})
