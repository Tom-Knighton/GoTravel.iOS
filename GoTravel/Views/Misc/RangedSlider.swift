//
//  RangedSlider.swift
//  GoTravel
//
//  Created by Tom Knighton on 27/03/2024.
//

import SwiftUI
import CompactSlider


public struct CustomCompactSliderStyle: CompactSliderStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(
                configuration.isHovering || configuration.isDragging ? .orange : .black
            )
            .background(
                Color.orange.opacity(0.1)
            )
            .accentColor(.orange)
            .compactSliderSecondaryColor(
                .orange,
                progressOpacity: 0.2,
                handleOpacity: 0.5,
                scaleOpacity: 1,
                secondaryScaleOpacity: 1
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

public extension CompactSliderStyle where Self == CustomCompactSliderStyle {
    static var yellow: CustomCompactSliderStyle { CustomCompactSliderStyle() }
}
