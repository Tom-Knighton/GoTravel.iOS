//
//  String+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 26/11/2023.
//

import Foundation
import SwiftUI

extension String: Error {}

extension LocalizedStringKey {
    
    /// Uses Mirroring/Reflection to grab the value of a LocalizedStringKey
    func toString() -> String {
        let mirror = Mirror(reflecting: self)
        
        let attributeLabelAndValue = mirror.children.first { (arg0) -> Bool in
            let (label, _) = arg0
            if (label == "key") {
                return true
            }
            
            return false
        }
        
        if let attributeLabelAndValue, let value = attributeLabelAndValue.value as? String {
            return String.localizedStringWithFormat(NSLocalizedString(value, comment: ""))
        }
        
        return ""
    }
}
