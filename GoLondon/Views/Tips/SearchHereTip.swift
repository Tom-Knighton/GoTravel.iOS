//
//  SearchHereTip.swift
//  GoLondon
//
//  Created by Tom Knighton on 05/11/2023.
//

import Foundation
import TipKit

public struct SearchHereTip: Tip {
    
    @Parameter
    static var isUsedToApp: Bool = false
    
    @Parameter
    static var hasCompletedActionInSession: Bool = false

    public var title: Text {
        Text(Strings.Map.HintSearchHere)
    }
    
    public var message: Text? {
        Text(Strings.Map.HintSearchHereText)
    }
    
    public var image: Image? {
        Image(systemName: Icons.location_magnifyingglass)
    }
    
    public var rules: [Rule] {
        [
            #Rule(Self.$hasCompletedActionInSession) { $0 == false }, // Don't show tip if action completed already
            #Rule(Self.$isUsedToApp) { $0 == false } // Don't show tip if user has used app enough times
        ]
    }
    
}
