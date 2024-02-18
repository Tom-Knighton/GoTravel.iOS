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
                    Text(Strings.Community.Join.JoinTag)
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(Strings.Community.Join.JoinDescription)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    CompetePanel()
                    TrackPanel()
                    SpecialChallengesPanel()
                    
                    Spacer()
                    
                    Button(action: { self.showLoginSection = true }) {
                        Text(Strings.Community.Join.StartNow)
                            .bold()
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .accessibilityLabel(Strings.Community.Join.StartNow)
                    .accessibilityHint(Strings.Community.Accessibility.StartNowHint)
                    
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
        .onChange(of: globalVm.currentUser) { _, newValue in
            if newValue != nil {
                self.showLoginSection = false
            }
        }
    }
    
    @ViewBuilder
    private func CompetePanel() -> some View {
        VStack {
            Text(Strings.Community.Join.Compete)
                .font(.headline.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(Strings.Community.Join.CompeteDesc)
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
                    Text(verbatim: "David_1988")
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Spacer()
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(.yellow)
                        .bold()
                    Text(verbatim: "300 pts")
                }
                Divider()
                HStack {
                    Image("BlankProfile3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .clipShape(.circle)
                        .shadow(radius: 3)
                    Text(Strings.Community.Join.You)
                        .bold()
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Spacer()
                    Text(verbatim: "290 pts")
                }
                Divider()
                HStack {
                    Image("BlankProfile2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .clipShape(.circle)
                        .shadow(radius: 3)
                    Text(verbatim: "TrailBlazer01!")
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    Spacer()
                    Text(verbatim: "207 pts")
                }
            }
            .padding(8)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.7), lineWidth: 1)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityElement()
            .accessibilityLabel(Strings.Community.Accessibility.ScoreboadLabel)
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
                Text(Strings.Community.Join.Track)
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(Strings.Community.Join.TrackDesc)
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
                Text(Strings.Community.Join.Special)
                    .font(.headline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(Strings.Community.Join.SpecialDesc)
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
            .navigationTitle(Strings.Navigation.CommunityTab)
    }
})
