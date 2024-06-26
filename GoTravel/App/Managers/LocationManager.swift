//
//  LocationManager.swift
//  GoTravel
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
        self.manager.startMonitoringSignificantLocationChanges()
        
        Task {
            if let _ = await JourneyManager.shared.currentJourney() {
                self.monitorBackground()
            }
        }
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
    public func requestAuth() {
        manager.requestAlwaysAuthorization()
    }
    
    public func monitorBackground() {
        manager.allowsBackgroundLocationUpdates = true
        manager.showsBackgroundLocationIndicator = true
        manager.pausesLocationUpdatesAutomatically = false
        manager.startMonitoringSignificantLocationChanges()
        manager.activityType = .otherNavigation
    }
    
    public func pauseBackgroundMonitoring() {
        manager.allowsBackgroundLocationUpdates = false
        manager.showsBackgroundLocationIndicator = false
        manager.pausesLocationUpdatesAutomatically = true
        manager.stopMonitoringSignificantLocationChanges()
        manager.activityType = .otherNavigation
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.status = manager.authorizationStatus
        NotificationCenter.default.post(name: .GLLocationPermissionsDidChange, object: nil, userInfo: [status: manager.authorizationStatus])
        
        Task {
            if let _ = await JourneyManager.shared.currentJourney() {
                self.monitorBackground()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task {
            if let current = await JourneyManager.shared.currentJourney() {
                await MainActor.run {
                    locations.forEach { loc in
                        current.coordinates.append(.init(loc))
                    }
                }
            }
        }
    }
}
