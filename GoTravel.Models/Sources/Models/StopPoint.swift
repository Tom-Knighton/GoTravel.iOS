//
//  StopPoint.swift
//  GoTravel
//
//  Created by Tom Knighton on 08/10/2023.
//

import Foundation
import Turf

public enum StopPoint: Decodable {
    case train(TrainStopPoint)
    case bus(BusStopPoint)
    case bike(BikeStopPoint)
    
    public var stopPoint: StopPointBase {
        switch self {
        case .bike(let bike):
            return bike
        case .bus(let bus):
            return bus
        case .train(let train):
            return train
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case stopPointType
    }
        
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let type = try? container.decode(String.self, forKey: CodingKeys.stopPointType) {
            switch type {
            case "Train":
                let train = try TrainStopPoint(from: decoder)
                self = .train(train)
                break
            case "Bus":
                let bus = try BusStopPoint(from: decoder)
                self = .bus(bus)
                break
            case "Bike":
                let bike = try BikeStopPoint(from: decoder)
                self = .bike(bike)
                break
            default:
                print("failed type check")
                throw DecodingError.typeMismatch(StopPoint.self, .init(codingPath: [CodingKeys.stopPointType], debugDescription: "Invalid stop point type"))
            }
        } else {
            print("failed type")
            throw DecodingError.typeMismatch(StopPoint.self, .init(codingPath: [CodingKeys.stopPointType], debugDescription: "No stop point type"))
        }
    }
}

public class StopPointBase: Decodable {
    
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
    
    public init(stopPointId: String, stopPointName: String, stopPointCoordinate: Point, stopPointHub: String?, stopPointParentId: String?, children: [StopPointBase], lineModes: [LineMode]) {
        self.stopPointId = stopPointId
        self.stopPointName = stopPointName
        self.stopPointCoordinate = stopPointCoordinate
        self.stopPointHub = stopPointHub
        self.stopPointParentId = stopPointParentId
        self.children = children
        self.lineModes = lineModes
    }
}
