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
                Text("Location disabled")
                Image(systemName: "location.slash")
                Spacer()
                Button(action: { onClose() }) {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .font(.system(.title3, design: .rounded).bold())
            
            Text("Want to know what stops are around you now? Grant Go London access to your location in Settings ")
                .font(.system(.subheadline, design: .rounded)) +
            Text(Image(systemName: "gear"))
                .font(.system(.subheadline, design: .rounded)) +
            Text(Image(systemName: "arrow.right"))
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
