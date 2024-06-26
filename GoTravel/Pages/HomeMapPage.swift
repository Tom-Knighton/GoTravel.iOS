//
//  HomeMapPage.swift
//  GoTravel
//
//  Created by Tom Knighton on 29/09/2023.
//

import SwiftUI
import MapKit
import Combine

public struct HomeMapPage: View {
    
    @Environment(LocationManager.self) private var locationManager
    @State private var viewModel = StopMapViewModel()
    @State private var filterViewModel = LineModeFilterViewModel()
    
    let searchTextPublisher = PassthroughSubject<String, Never>()

    public var body: some View {
        ZStack {
            Map(position: $viewModel.mapPosition, interactionModes: [.pan, .pitch, .zoom]) {
                UserAnnotation()
                
                ForEach(viewModel.stopPoints, id: \.stopPoint.stopPointId) { stopPoint in
                    Annotation(coordinate: stopPoint.stopPoint.stopPointCoordinate.coordinates, anchor: .bottom) {
                        StopPointMarkerView(stopPoint: stopPoint)
                            .onTapGesture {
                                self.viewModel.scrollSearchResults(to: stopPoint.stopPoint.stopPointId)
                            }
                    } label: {
                        Text(stopPoint.stopPoint.stopPointName)
                    }

                }
                
                if let searchedLocation = viewModel.searchedLocation {
                    MapCircle(center: searchedLocation, radius: CLLocationDistance(viewModel.searchDistance))
                        .foregroundStyle(.clear)
                        .stroke(.blue, lineWidth: 1)
                }
            }
            .ignoresSafeArea(.keyboard)
            .ignoresSafeArea(.container)
            .mapControlVisibility(.hidden)
            .mapStyle(.standard(pointsOfInterest: .excludingAll, showsTraffic: true))
            .onMapCameraChange { context in
                self.viewModel.mapPannedCenter = context.camera.centerCoordinate
            }
            .onChange(of: viewModel.filterSheetOpen, initial: false) { _, newVal in
                if !newVal {
                    Task {
                        await viewModel.searchAtMapCenter()
                    }
                }
            }
            
            mapControls()
            
            noLocationBanner()
        }
        .safeAreaPadding([.bottom], 70)
        .sheet(isPresented: $viewModel.filterSheetOpen) {
            LineModeFilterView()
                .environment(filterViewModel)
        }
        .bottomSheet(bottomSheetPosition: $viewModel.sheetPosition, switchablePositions: viewModel.sheetPositions, headerContent: {
            MapSheetSearchBar(text: $viewModel.searchText)
                .onTapGesture {
                    if let top = self.viewModel.sheetPositions.last {
                        viewModel.sheetPosition = top
                    }
                }
        }) {
            MapSheetSearchResults(isNearby: $viewModel.searchSheetShowNearby, searchResults: viewModel.searchSheetShowNearby ? $viewModel.stopPoints : $viewModel.searchResults, scrollToId: $viewModel.scrollToId)
        }
        .customAnimation(.spring)
        .onChange(of: self.viewModel.searchText, { _, newValue in
            self.searchTextPublisher.send(newValue)
            viewModel.searchSheetShowNearby = newValue.trimmingCharacters(in: .whitespacesAndNewlines).count < 3
        })
        .onReceive(searchTextPublisher.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main), perform: { val in
            self.viewModel.searchStopPoints(val)
        })
        .task {
            await viewModel.searchAtUserLoc()
        }
        
    }
}

extension HomeMapPage {
    
    private var shouldShowBanner: Bool {
        !viewModel.locationBannerClosed && !locationManager.isLocationGranted
    }
    
    @ViewBuilder
    func noLocationBanner() -> some View {
        if shouldShowBanner {
            VStack {
                LocationNeededBanner(onClose: { withAnimation(.easeInOut(duration: 1)) {
                    viewModel.locationBannerClosed = true
                }})
                    .padding(.horizontal, 12)
                    .gesture(
                        DragGesture()
                            .onChanged({ val in
                                withAnimation(.linear) {
                                    self.viewModel.locationBannerOffser = val.translation.height
                                }
                            })
                            .onEnded({ val in
                                if abs(val.translation.height) > 50 {
                                    withAnimation(.easeInOut(duration: 1)) {
                                        self.viewModel.locationBannerClosed = true
                                    }
                                } else {
                                    self.viewModel.locationBannerOffser = .zero
                                }
                            })
                    )
                    .offset(y: self.viewModel.locationBannerOffser)
                    .onTapGesture {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }
                    .transition(.move(edge: .top))
                Spacer()
            }
        }
    }
}

extension HomeMapPage {
    
    @ViewBuilder
    func mapControls() -> some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                Spacer().frame(height: 8)
                
                Button(action: { self.userLocationTapped() }) {
                    Image(systemName: Icons.location)
                }
                .buttonStyle(.mapControl)
                .accessibilityLabel(Strings.Accessibility.MapLabelUserSearch)
                .accessibilityHint(Strings.Accessibility.MapHintUserSearch)
                
                Button(action: { self.searchHereTapped() }) {
                    if self.viewModel.isSearching {
                        ProgressView()
                            .progressViewStyle(.circular)
                    } else {
                        Image(systemName: Icons.location_magnifyingglass)
                    }
                }
                .buttonStyle(.mapControl)
                .popoverTip(SearchHereTip(), arrowEdge: .top)
                .accessibilityLabel(Strings.Accessibility.MapLabelMapSearch)
                .accessibilityHint(Strings.Accessibility.MapHintMapSearch)
                
                Button(action: { openFilterSheet() }) {
                    Image(systemName: Icons.filter)
                }
                .buttonStyle(.mapControl)
                .accessibilityLabel(Strings.Accessibility.MapLabelFilterSheet)
                .accessibilityHint(Strings.Accessibility.MapHintFilterSheet)
                
                Spacer()
            }
        }
        .padding(.horizontal, 12)
    }
    
    func userLocationTapped() {
        if let loc = LocationManager.shared.manager.location {
            self.viewModel.goToLocation(loc.coordinate)
            Task {
                await self.viewModel.searchAtUserLoc()
            }
        }
    }
    
    func searchHereTapped() {
        AppData.shared.hasUsedSearchAround = true
        SearchHereTip.hasCompletedActionInSession = true
        
        Task {
            await self.viewModel.searchAtMapCenter()
        }
    }
    
    func openFilterSheet() {
        self.filterViewModel.load(for: self.viewModel.mapPannedCenter)
        self.viewModel.filterSheetOpen.toggle()
    }
}
