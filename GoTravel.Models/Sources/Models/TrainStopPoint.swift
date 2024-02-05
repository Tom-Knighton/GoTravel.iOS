//
//  TrainStopPoint.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation
import Turf

/// Represents a stop point at which trains stop
public class TrainStopPoint: StopPointBase {

    public override init(stopPointId: String, stopPointName: String, stopPointCoordinate: Point, stopPointHub: String?, stopPointParentId: String?, children: [StopPointBase], lineModes: [LineMode]) {
        super.init(stopPointId: stopPointId, stopPointName: stopPointName, stopPointCoordinate: stopPointCoordinate, stopPointHub: stopPointHub, stopPointParentId: stopPointParentId, children: children, lineModes: lineModes)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
