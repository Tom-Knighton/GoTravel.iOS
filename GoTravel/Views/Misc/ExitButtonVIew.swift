//
//  ExitButtonVIew.swift
//  GoTravel
//
//  https://github.com/joogps/ExitButton
//

import SwiftUI

public struct ExitButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    
    public var body: some View {
        ZStack {
            Circle()
                .fill(Material.regular)
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .font(Font.body.weight(.bold))
                .scaleEffect(0.416)
                .foregroundColor(Color(white: colorScheme == .dark ? 0.62 : 0.51))
        }
        .frame(width: 24, height: 24)
    }
}
