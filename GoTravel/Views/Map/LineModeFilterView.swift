//
//  LineModeFilterView.swift
//  GoTravel
//
//  Created by Tom Knighton on 05/12/2023.
//

import SwiftUI
import GoTravel_CoreData
import GoTravel_Models
import SwiftData

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
                    LineModeFilterAreaView(areaName: area.areaName, lineModes: area.lineModes) { toggledLineMode in
                        self.viewModel.toggleLineMode(lineMode: toggledLineMode)
                    }
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
    
    private var isNearby: Bool
    private var callback: (_ lineMode: String) -> Void
    private let flatLMNames: [String]
    
    @State private var showSection: Bool = false
    @Query private var hiddenLineModes: [HiddenLineMode]
    @AccessibilityFocusState private var isFocused: Bool
    
    public init(areaName: String, lineModes: [LineMode], toggledCallback: @escaping (_ lineMode: String) -> Void) {
        self.areaName = areaName
        self.lineModes = lineModes
        
        let isNearby = areaName == Strings.Map.LineModeFilterNearby.toString()
        self.isNearby = isNearby
        self._showSection = State(wrappedValue: isNearby)
        self.callback = toggledCallback
        
        flatLMNames = lineModes.compactMap { $0.lineModeName }
        _hiddenLineModes = Query(filter: #Predicate<HiddenLineMode> { hidden in
            flatLMNames.contains(hidden.lineModeName)
        })
    }
    
    public var body: some View {
        VStack {
            Button(action: { toggleSection() }) {
                HStack {
                    Text(areaName)
                        .font(.title3.bold())
                        .fontDesign(.rounded)
                        .if(!self.isNearby) { view in
                            view.accessibilityHidden()
                        }
                    Spacer()
                    
                    if !self.isNearby {
                        Image(systemName: Icons.arrow_right)
                            .accessibilityHidden()
                    }
                }
            }
            .tint(.primary)
            .accessibilityFocused($isFocused)
            .accessibilityAddTraits(.isHeader)
            .accessibilityHint("Line modes for the \(areaName) area. \(isNearby ? "" : "Tap to \(showSection ? "collapse" : "expand")")")
            .if(self.isNearby) { view in
                view
                    .accessibilityRemoveTraits(.isButton)
                    .accessibilityAddTraits(.isStaticText)
            }
            
            if self.showSection {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(lineModes, id: \.lineModeName) { lineMode in
                        let isHidden = isLineModeHidden(lineModeName: lineMode.lineModeName)
                        Button(action: { self.lineModeTapped(lineMode: lineMode) }) {
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
                                Spacer().frame(height: 30)
                            }
                            .frame(maxWidth: .infinity, minHeight: 150, maxHeight: .infinity)
                            .background(isHidden ? .layer3 : .blue)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 3)
                            .tint(.primary)
                            .accessibilityHidden()
                        }
                        .accessibilityHint("\(isHidden ? "Re-enables" : "Hides all") \(lineMode.lineModeName) stops on the map")
                    }
                }
            }
        }
    }
    
    @MainActor
    private func toggleSection() {
        guard !isNearby else { return }
        
        withAnimation {
            self.showSection.toggle()
        }
        
        if self.showSection {
            AccessibilityHelper.postMessage("Added \(lineModes.count) line modes for the \(areaName) area to the view", messageType: .layoutChanged)
        } else {
            AccessibilityHelper.postMessage("Hidden \(lineModes.count) line modes for the \(areaName) area from the view", messageType: .layoutChanged)
        }
        self.isFocused = true
    }
    
    private func lineModeTapped(lineMode: LineMode) {
        self.callback(lineMode.lineModeName)
    }
    
    private func isLineModeHidden(lineModeName: String) -> Bool {
        return hiddenLineModes.contains { hidden in
            hidden.lineModeName == lineModeName && hidden.hidden
        }
    }
}
