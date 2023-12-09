//
//  LineModeFilterView.swift
//  GoTravel
//
//  Created by Tom Knighton on 05/12/2023.
//

import SwiftUI
import GoTravel_Models

public struct LineModeFilterView: View {
    
    @Environment(LineModeFilterViewModel.self) private var viewModel
    
    public var body: some View {
        VStack {
            Text(Strings.Map.LineModeFilterTitle)
                .font(.title)
                .fontDesign(.rounded)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(Strings.Map.LineModeFilterSubtitle)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let error = viewModel.errorMessage {
                Text(error)
            }
            
            if !viewModel.isLoading && viewModel.lineModeGroups.isEmpty {
                ContentUnavailableView(Strings.Errors.NoLineModesAPI, systemImage: Icons.map_circle, description: Text(Strings.Errors.NoLineModesAPIDescription))
            }
            
            ScrollView {
                ForEach(viewModel.lineModeGroups, id: \.areaName) { area in
                    LineModeFilterAreaView(areaName: area.areaName, lineModes: area.lineModes)
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 12)
    }
}

public struct LineModeFilterAreaView: View {
    
    
    public let areaName: String
    public let lineModes: [LineMode]
    @State private var showSection: Bool = false
    
    private var isNearby: Bool
    
    public init(areaName: String, lineModes: [LineMode]) {
        self.areaName = areaName
        self.lineModes = lineModes
        
        let isNearby = areaName == Strings.Map.LineModeFilterNearby.toString()
        self.isNearby = isNearby
        self._showSection = State(wrappedValue: isNearby)
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(areaName)
                    .font(.title3.bold())
                    .fontDesign(.rounded)
                Spacer()
                
                if !self.isNearby {
                    Image(systemName: Icons.arrow_right)
                }
            }
            .contentShape(.rect)
            .onTapGesture {
                if !self.isNearby {
                    withAnimation {
                        self.showSection.toggle()
                    }
                }
            }
            
            if self.showSection {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(lineModes, id: \.lineModeName) { lineMode in
                        Button(action: {}) {
                            VStack {
                                Spacer().frame(height: 16)
                                Text(lineMode.lineModeName)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                Spacer()
                                AsyncImage(url: URL(string: lineMode.branding.lineModeLogoUrl), content: { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .shadow(radius: 3)
                                }, placeholder: {
                                    ProgressView()
                                })
                                .accessibilityHidden(true)
                                Spacer().frame(height: 30)
                            }
                            .frame(maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
                            .background(.layer3)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 3)
                            .tint(.primary)
                        }
                        .accessibilityHint("Shows/hides \(lineMode.lineModeName) stops on the mapll")
                    }
                }
            }
        }   
    }
}
