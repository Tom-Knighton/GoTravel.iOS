//
//  RadioToggleStyle.swift
//  GoTravel
//
//  Created by Tom Knighton on 05/02/2024.
//

import SwiftUI

public struct RadioToggleStyle: ToggleStyle {
    
    public func makeBody(configuration: Configuration) -> some View {
        Button {
            withAnimation {
                configuration.isOn.toggle()
            }
        } label: {
            HStack {
                configuration.label
                Spacer()
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(configuration.isOn ? Color.accentColor : .secondary)
                    .imageScale(.large)
            }
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
    }
}
