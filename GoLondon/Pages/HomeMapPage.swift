//
//  HomeMapPage.swift
//  GoLondon
//
//  Created by Tom Knighton on 29/09/2023.
//

import SwiftUI
import MapKit

public struct HomeMapPage: View {
    
    public var body: some View {
        Map(interactionModes: [.pan, .pitch, .zoom]) {
        }
        .mapControlVisibility(.hidden)
        .mapStyle(.standard(pointsOfInterest: .excludingAll, showsTraffic: true))
    }
}
