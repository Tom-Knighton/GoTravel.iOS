//
//  StopPoint.swift
//  GoLondon
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation
import Turf

public class StopPointBase: Codable {
    
    /// The unique Id of the stop point
    public let stopPointId: String
    
    /// A friendly name of the stop point, displayed on maps
    public let stopPointName: String
    
    /// The coordinate of the stop point
    public let stopPointCoordinate: Point
    
    /// If the stop point is part of a hub, this is the id of the hub
    public let stopPointHub: String?
        
    /// If the stop point has a parent, this is the id of the parent
    public let stopPointParentId: String?
    
    /// Any child stop points
    public let children: [StopPointBase]
    
    /// The line modes and their lines operating at this stop point
    public let lineModes: [LineMode]
}
