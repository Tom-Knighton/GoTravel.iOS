//
//  GoTravelCoreData.swift
//  
//
//  Created by Tom Knighton on 05/12/2023.
//

import Foundation
import SwiftData

public class GoTravelCoreData {
    public static let AllModels: [any PersistentModel.Type] = 
    [
        LineModeCache.self,
        LineModeBrandingCache.self,
        LineModeAreaCache.self,
        HiddenLineMode.self
    ]
    
}
