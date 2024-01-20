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
                    ContentUnavailableView("No Stop", systemImage: "xmark")
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
        }
    }
    
    @ViewBuilder func content(_ stopPoint: StopPoint) -> some View {
        VStack {
            Spacer().frame(height: 16)
            LineModesView(stop: stopPoint)
            Spacer().frame(height: 16)
            
            MapPreview(stopPoint)
            Button(action: {}) {
                Text("Go Now")
                    .fontDesign(.rounded)
                    .bold()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer().frame(height: 16)
            StopArrivalsView()
                .environment(viewModel)
            
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
            return "Loading..."
        }
        
        return stop.stopPoint.stopPointName
    }
}

#Preview {
    NavigationStack {
        StopPointPage(stopId: "HUBSRA")
    }
}
