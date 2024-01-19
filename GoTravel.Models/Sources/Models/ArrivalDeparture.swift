//
//  ArrivalDeparture.swift
//
//
//  Created by Tom Knighton on 18/01/2024.
//

import Foundation

/// Represents an arrival, or departure, of a mode of transport
public struct ArrivalDeparture: Decodable {
    
    /// The id assigned to this entry by the mode's operator
    public let operatorsArrivalId: String
    
    /// The company operating this arrival/departure
    public let `operator`: String
    
    /// Some operators assign unique vehicle ids to arrivals, this may be the license plate of a bus, or the id of a train. These may not be unique.
    public let vehicleId: String?
    
    /// The id of the stop this arrival/departure is arriving at or departing from
    public let stopId: String
    
    /// The predicted arrival time of this entry. May not be present.
    public let predictedArrival: Date?
    
    /// The predicted departure time of this entry. May not be present.
    public let predictedDeparture: Date?
    
    /// The scheduled (according to timetable) arrival time for this entry.
    public let scheduledArrival: Date?
    
    /// The scheduled (according to timetable departure time for this entry.
    public let scheduledDeparture: Date?
    
    /// Some operators provide the friendly name for the (final) destination stop
    public let destinationName: String?
    
    /// The id of the final destination stop
    public let destinationStopId: String
    
    /// Whether or not this entry is cancelled by the operator
    public let isCancelled: Bool
    
    /// Whether or not the entry is MARKED as delayed by the operator. This being false does not mean the entry is not delayed,
    /// this is only true specifically when the operator has marked it as such/
    public let isDelayed: Bool
    
    /// The name of the platform this arrival/departure is arriving at/departing from
    public let platform: String
    
    /// Some entries have a  direction name i.e. North, or inbound/outbound
    public let direction: String?
    
    /// The line id this arrival is for
    public let line: String
    
    /// The line mode the line operates under
    public let lineMode: String
}
