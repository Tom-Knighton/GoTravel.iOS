//
//  LocationManager.swift
//  GoLondon
//
//  Created by Tom Knighton on 30/09/2023.
//

import Foundation
import CoreLocation

@Observable
class LocationManager: NSObject {
    
    public static let shared = LocationManager()
    
    public var status: CLAuthorizationStatus? = nil
    
    public var manager: CLLocationManager = CLLocationManager()
    private var allowedStatuses: [CLAuthorizationStatus] = [.authorizedAlways, .authorizedWhenInUse]
    
    override init() {
        super.init()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.startUpdatingLocation()
        self.manager.startUpdatingHeading()
    }
    
    /// Whether or not the app is allowed access to the user's location
    public var isLocationGranted: Bool {
        if let status { return allowedStatuses.contains(status) }
        return true
    }
    
    /// True if the user has not yet chosen whether the app should have permission or not
    public var locationUndetermined: Bool {
        status == .notDetermined
    }
    
    /// Request's the user's location
    func requestAuth() {
        manager.requestAlwaysAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.status = manager.authorizationStatus
        NotificationCenter.default.post(name: .GLLocationPermissionsDidChange, object: nil, userInfo: [status: manager.authorizationStatus])
    }
}
