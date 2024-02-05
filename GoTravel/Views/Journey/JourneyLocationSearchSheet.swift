//
//  JourneyLocationSearchSheet.swift
//  GoTravel
//
//  Created by Tom Knighton on 02/02/2024.
//

import SwiftUI
import GoTravel_Models
import Combine
import CoreLocation

public struct JourneyLocationSearchSheet: View {
    
    private var type: JourneyStopSearchType
    private var onSelected: (_:JourneyRequestPoint) -> Void
    
    @Environment(LocationManager.self) private var location
    @Environment(JourneyPlannerViewModel.self) private var vm
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOverEnabled
    @Environment(\.dismiss) private var dismiss
    @State private var text: String = ""
    @FocusState private var isFocused: Bool
    let searchTextPublisher = PassthroughSubject<String, Never>()
    
    public init(type: JourneyStopSearchType, onSelection: @escaping (_:JourneyRequestPoint) -> Void) {
        self.type = type
        self.onSelected = onSelection
    }

    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            ScrollView {
                if voiceOverEnabled {
                    Spacer().frame(height: 16)
                    HStack {
                        Spacer()
                        Button(action: { self.dismiss() }) {
                            ExitButtonView()
                        }
                    }
                }
                Spacer().frame(height: 8)
                Text(getTitle())
                    .font(.title3.bold())
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    TextField("", text: $text, prompt: Text(getPrompt()))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .focused($isFocused)
                    
                    if self.text.count > 0 {
                        Button(action: { self.text = "" }) {
                            Image(systemName: Icons.cross_circle_fill)
                        }
                        .tint(.primary)
                    }
                    
                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
                
                if let location = location.manager.location?.coordinate {
                    CurrentLocationButton(location)
                }
                
                
                if self.text.count < 3 {
                    ContentUnavailableView(getSearchTitle(), systemImage: Icons.location_magnifyingglass, description: Text(getSearchDescription()))
                } else {
                    if vm.isSearching {
                        ContentUnavailableView(Strings.JourneyPage.Searching, systemImage: Icons.location_magnifyingglass)
                    } else {
                        if vm.searchResults.isEmpty {
                            ContentUnavailableView(Strings.JourneyPage.SearchNoResultsTitle, systemImage: Icons.mapPinSlashed, description: Text(Strings.JourneyPage.SearchNoResultsDescription))
                        }
                        LazyVStack {
                            ForEach(vm.searchResults, id: \.stopPoint.stopPointId) { stop in
                                MapSheetSearchResultItem(item: stop, isSelected: false)
                                    .onTapGesture {
                                        self.onSelected(JourneyRequestPoint(displayName: stop.stopPoint.stopPointName, coordinate: stop.stopPoint.stopPointCoordinate.coordinates))
                                    }
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .contentMargins(16)
        }
        .onAppear {
            self.isFocused = true
        }
        .onChange(of: self.text, { _, newValue in
            self.searchTextPublisher.send(newValue)
            if newValue.count > 3 {
                self.vm.isSearching = true
            }
        })
        .onReceive(searchTextPublisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main), perform: { val in
            Task {
                await self.vm.searchStops(val)
            }
        })
    }
    
    private func getTitle() -> LocalizedStringKey {
        switch type {
        case .from:
            return Strings.JourneyPage.ChooseStart
        case .to:
            return Strings.JourneyPage.ChooseEnd
        case .via:
            return Strings.JourneyPage.ChooseVia
        }
    }
    
    private func getSearchTitle() -> LocalizedStringKey {
        switch type {
        case .from:
            return Strings.JourneyPage.SearchBeginTitle
        case .to:
            return Strings.JourneyPage.SearchEndTitle
        case .via:
            return Strings.JourneyPage.SearchViaTitle
        }
    }
    
    private func getSearchDescription() -> LocalizedStringKey {
        switch type {
        case .from:
            return Strings.JourneyPage.SearchBeginDescription
        case .to:
            return Strings.JourneyPage.SearchEndDescription
        case .via:
            return Strings.JourneyPage.SearchViaDescription
        }
    }
    
    private func getPrompt() -> LocalizedStringKey {
        switch type {
        case .from:
            return Strings.JourneyPage.FromPrompt
        case .to:
            return Strings.JourneyPage.ToPrompt
        case .via:
            return Strings.JourneyPage.ViaPrompt
        }
    }
    
    @ViewBuilder
    private func CurrentLocationButton(_ location: CLLocationCoordinate2D) -> some View {
        HStack {
            Button(action: {
                self.onSelected(JourneyRequestPoint(displayName: Strings.JourneyPage.MyLocation.toString(), coordinate: location))
            }) {
                HStack {
                    Image(systemName: Icons.locationFill)
                    Text(Strings.JourneyPage.MyLocation)
                        .bold()
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, minHeight: 40, alignment: .leading)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        
    }
}

