//
//  String+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 26/11/2023.
//

import Foundation
import SwiftUI

extension String: Error {}

extension LocalizedStringKey: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.toString())
    }
    
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

extension String {
    
    public func isEmail() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return false
        }
        
        let range = NSMakeRange(0, NSString(string: trimmed).length)
        let allMatches = dataDetector.matches(in: trimmed,
                                              options: [],
                                              range: range)

        if allMatches.count == 1 && allMatches.first?.url?.absoluteString.contains("mailto:") == true
        {
            return true
        }
        return false
    }
    
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }

    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
