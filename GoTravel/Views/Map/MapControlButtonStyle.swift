//
//  MapButtonStyle.swift
//  GoTravel
//
//  Created by Tom Knighton on 05/12/2023.
//

import SwiftUI

public struct MapControlButtonStyle: ButtonStyle {
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 45, minHeight: 45)
            .background(Material.thick)
            .clipShape(.rect(cornerRadius: 10))
    }
}
