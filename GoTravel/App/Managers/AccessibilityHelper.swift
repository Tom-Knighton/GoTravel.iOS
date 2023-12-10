//
//  AccessibilityHelper.swift
//  GoTravel
//
//  Created by Tom Knighton on 10/12/2023.
//

import Foundation
import UIKit

public struct AccessibilityHelper {
    
    public enum MessageType {
        case layoutChanged
        case screenChanged
        case announcement
        
        func toUIKit() -> UIAccessibility.Notification {
            switch self {
            case .layoutChanged:
                return .layoutChanged
            case .screenChanged:
                return .screenChanged
            case .announcement:
                return .announcement
            default:
                return .announcement
            }
        }
    }
    
    @MainActor
    public static func postMessage(_ message: String, messageType: MessageType = .announcement) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIAccessibility.post(notification: .screenChanged, argument: message)
        }
    }
}
