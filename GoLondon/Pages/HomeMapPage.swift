//
//  HomeMapPage.swift
//  GoLondon
//
//  Created by Tom Knighton on 29/09/2023.
//

import SwiftUI
import MapKit

public struct HomeMapPage: View {
    
    @Environment(LocationManager.self) private var locationManager

    @State private var viewModel = StopMapViewModel()
    
    public var body: some View {
        ZStack {
            Map(position: $viewModel.mapPosition, interactionModes: [.pan, .pitch, .zoom]) {
                UserAnnotation()
                
                ForEach(viewModel.stopPoints, id: \.stopPoint.stopPointId) { stopPoint in
                    Annotation(coordinate: stopPoint.stopPoint.stopPointCoordinate.coordinates, anchor: .bottom) {
                        StopPointMarkerView(stopPoint: stopPoint)
                    } label: {
                        Text(stopPoint.stopPoint.stopPointName)
                    }

                }
                
                if let searchedLocation = viewModel.searchedLocation {
                    MapCircle(center: searchedLocation.coordinate, radius: CLLocationDistance(viewModel.searchDistance))
                        .foregroundStyle(.clear)
                        .stroke(.blue, lineWidth: 1)
                }
            }
            .mapControlVisibility(.hidden)
            .mapStyle(.standard(pointsOfInterest: .excludingAll, showsTraffic: true))
            
            noLocationBanner()
        }
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
