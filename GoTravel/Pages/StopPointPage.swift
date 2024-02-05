//
//  StopPointPage.swift
//  GoTravel
//
//  Created by Tom Knighton on 16/01/2024.
//

import SwiftUI
import GoTravel_Models
import MapKit

public struct StopPointPage: View {
    
    @State private var viewModel = StopPointViewModel()
    private let stopId: String
    
    
    public init(stopId: String) {
        self.stopId = stopId
    }
    
    public var body: some View {
        ZStack {
            Color.layer1.ignoresSafeArea()
            
            if !viewModel.isLoading {
                if let stopPoint = viewModel.stopPoint {
                    ScrollView {
                        content(stopPoint)
                    }
                } else {
                    ContentUnavailableView(Strings.Errors.StopFailedLoad, systemImage: Icons.cross_circle_fill)
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(getNavTitle())
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(.automatic, for: .navigationBar)
        .task {
            await viewModel.load(self.stopId)
            await viewModel.loadArrivals()
            await viewModel.loadInfo()
        }
    }
    
    @ViewBuilder func content(_ stopPoint: StopPoint) -> some View {
        VStack {
            Spacer().frame(height: 16)
            LineModesView(stop: stopPoint)
            Spacer().frame(height: 16)
            
            MapPreview(stopPoint)
                .accessibilityLabel(Strings.Accessibility.MapShowsStopLabel)
                .accessibilityElement(children: .combine)
            
            Button(action: { GlobalViewModel.shared.addToCurrentNavStack(QuickJourneyNavModel(destination: .init(displayName: stopPoint.stopPoint.stopPointName, coordinate: stopPoint.stopPoint.stopPointCoordinate.coordinates))) }) {
                Text(Strings.StopPage.GetDirectionsButton)
                    .fontDesign(.rounded)
                    .bold()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .accessibilityHint(Strings.Accessibility.OpensJourneyForStopLabel)
            
            Spacer().frame(height: 16)
            StopArrivalsView()
                .environment(viewModel)
            
            Spacer().frame(height: 16)
            if let info = viewModel.information {
                StopPointInfoView(info: info, coords: stopPoint.stopPoint.stopPointCoordinate.coordinates, hideAccessible: stopPoint.stopPoint is BusStopPoint)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private func MapPreview(_ stopPoint: StopPoint) -> some View {
        let coordinate = stopPoint.stopPoint.stopPointCoordinate.coordinates
        Map(initialPosition: .camera(.init(centerCoordinate: .init(latitude: coordinate.latitude, longitude: coordinate.longitude), distance: 2000)), interactionModes: []) {
            
            Annotation(coordinate: coordinate, anchor: .bottom) {
                StopPointMarkerView(stopPoint: stopPoint)
            } label: {
                Text(stopPoint.stopPoint.stopPointName)
            }
        }
        .mapControlVisibility(.hidden)
        .mapStyle(.standard(pointsOfInterest: .excludingAll, showsTraffic: true))
        .frame(height: 150)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
    }
    
    private func getNavTitle() -> String {
        guard let stop = self.viewModel.stopPoint else {
            return Strings.Misc.Loading.toString()
        }
        
        return stop.stopPoint.stopPointName
    }
}

#Preview {
    NavigationStack {
        StopPointPage(stopId: "HUBSRA")
    }
}
