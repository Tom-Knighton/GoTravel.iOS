//
//  NotificationCenter+GoTravel.swift
//  GoTravel
//
//  Created by Tom Knighton on 07/10/2023.
//

import Foundation

extension NSNotification.Name {
    
    /// Represents an event notifying the user the app's location permissions did change
    /// This may be triggered even if the permissions haven't *actually* changed, but have just been loaded
    public static let GLLocationPermissionsDidChange: NSNotification.Name = .init("GL_LOCATION_PERMISSIONS_DID_CHANGE")
}
