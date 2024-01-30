//
//  JourneyPlannerPage.swift
//  GoTravel
//
//  Created by Tom Knighton on 28/01/2024.
//

import SwiftUI
import GoTravel_Models
import GoTravel_API
import Turf
import Combine

public struct JourneyPlannerPage: View {
    
    @State private var viewModel = JourneyPlannerViewModel()
    @State private var showSearchSheetType: JourneyPlannerSearchSheetType? = nil

    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            
            ScrollView {
                
                Text("Plan a trip:")
                    .font(.title3.bold())
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    VStack {
                        LocationField(promptText: "From:", imageName: "location.magnifyingglass", type: .from)
                        LocationField(promptText: "To:", imageName: "location.magnifyingglass", type: .to)
                    }
                    
                    VStack {
                        Button(action: {}) {
                            Image(systemName: "arrow.up.arrow.down")
                                .resizable()
                                .frame(width: 15, height: 15)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        .buttonStyle(.borderedProminent)
                        
                        if !viewModel.showViaField {
                            Button(action: { withAnimation { viewModel.showViaField = true } }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.white)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                            .buttonStyle(.borderedProminent)
                            .transition(.slide.combined(with: .opacity))
                        }
                        
                    }
                    .frame(width: 40)
                }
                
                if viewModel.showViaField {
                    HStack {
                        LocationField(promptText: "Via:", imageName: "location.magnifyingglass", type: .via)
                        Button(action: { withAnimation { viewModel.showViaField = false } }) {
                            Image(systemName: "minus")
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                                .clipShape(.rect(cornerRadius: 10))
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.red)
                        .transition(.slide.combined(with: .opacity))
                        .frame(width: 40)
                    }
                }
                
                
                HStack {
                    Button(action: {}) {
                        Text("Plan Journey")
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                Spacer()
            }
            .contentMargins(16)
        }
        .navigationTitle("Journeys")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                }
            }
        }
        .sheet(item: $showSearchSheetType) { type in
            SearchLocView(type: type)
                .environment(viewModel)
        }
    }
    
    
    @ViewBuilder
    private func LocationField(promptText: String, imageName: String, type: JourneyPlannerSearchSheetType) -> some View {
        HStack {
            Button(action: {}) {
                Image(systemName: imageName)
                    .shadow(radius: 3)
            }
            Text(promptText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color.layer2)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
        .onTapGesture {
            self.showSearchSheetType = type
        }
    }
}

private struct SearchLocView: View {
    
    public var type: JourneyPlannerSearchSheetType
    
    @Environment(JourneyPlannerViewModel.self) private var vm
    @State private var text: String = ""
    @FocusState private var isFocused: Bool
    let searchTextPublisher = PassthroughSubject<String, Never>()

    var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            ScrollView {
                Spacer().frame(height: 8)
                Text(getTitle())
                    .font(.title3.bold())
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    TextField("", text: $text, prompt: Text("From:"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .focused($isFocused)
                }
                .padding(.horizontal, 8)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.layer2)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 3)
                
                CurrentLocationButton()
                
                LazyVStack {
                    ForEach(vm.searchResults, id: \.stopPoint.stopPointId) { stop in
                        MapSheetSearchResultItem(item: stop, isSelected: false)
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
    
    @ViewBuilder
    private func CurrentLocationButton() -> some View {
        HStack {
            Button(action: {}) {
                HStack {
                    Image(systemName: "location.fill")
                    Text("My Current Location")
                        .bold()
                        .fontDesign(.rounded)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        
    }
}


#Preview {
    SearchLocView(type: .from)
        .environment(GlobalViewModel())
        .environment(JourneyPlannerViewModel())
}
