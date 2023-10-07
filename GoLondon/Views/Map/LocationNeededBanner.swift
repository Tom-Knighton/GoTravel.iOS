//
//  LocationNeededBanner.swift
//  GoLondon
//
//  Created by Tom Knighton on 30/09/2023.
//

import SwiftUI

public struct LocationNeededBanner: View {
    
    var onClose: () -> Void
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(Strings.Map.LocationDisabled)
                Image(systemName: Icons.location_slash)
                Spacer()
                Button(action: { onClose() }) {
                    Image(systemName: Icons.cross_circle_fill)
                }
            }
            .font(.system(.title3, design: .rounded).bold())
            
            Text(Strings.Map.EnableLocationStopPoints)
                .font(.system(.subheadline, design: .rounded)) +
            Text(Image(systemName: Icons.gear))
                .font(.system(.subheadline, design: .rounded)) +
            Text(Image(systemName: Icons.arrow_right))
                .font(.system(.subheadline, design: .rounded))
        }
        .padding(6)
        .frame(maxWidth: .infinity)
        .background(.linearGradient(Gradient(colors: [.blue, .green]), startPoint: .bottomLeading, endPoint: .topTrailing))
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 3)
        .foregroundStyle(.white)
    }
}
