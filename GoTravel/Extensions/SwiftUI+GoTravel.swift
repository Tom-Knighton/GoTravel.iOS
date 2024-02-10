//
//  SwiftUI+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 05/12/2023.
//

import SwiftUI

extension ButtonStyle where Self == MapControlButtonStyle {
    
    public static var mapControl: Self { Self() }
}

extension View {
    
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

extension Int: Identifiable {
    public var id: Int {
        return self
    }
}
