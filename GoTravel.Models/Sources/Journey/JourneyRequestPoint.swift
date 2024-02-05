//
//  JourneyRequestPoint.swift
//
//
//  Created by Tom Knighton on 30/01/2024.
//

import Foundation
import CoreLocation

public struct JourneyRequestPoint {
    
    public let displayName: String
    public let coordinate: CLLocationCoordinate2D
    
    public init(displayName: String, coordinate: CLLocationCoordinate2D) {
        self.displayName = displayName
        self.coordinate = coordinate
    }
}
