//
//  BeaconManager.swift
//  BeaconNavigator
//
//  Created by Alex Deutsch on 10.06.15.
//  Copyright (c) 2015 Alexander Deutsch. All rights reserved.
//

import CoreLocation
import Accelerate

let BeaconManagerDidUpdateAvailableBeacons = "beaconManagerDidUpdateAvailableBeacons"

class BeaconManager : NSObject, CLLocationManagerDelegate {
    
    static let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")
    
    static let sharedInstance = BeaconManager()
    
    private let locationManager = CLLocationManager()
    
    private var allKnownBeacons : [CLBeacon] = []
    var currentAvailableBeacons : [CLBeacon] = []
    
    override init() {
        super.init()
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedAlways {
            locationManager.requestAlwaysAuthorization()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.startRangingBeacons(in: BeaconManager.region)
        locationManager.startMonitoring(for: BeaconManager.region)
        BeaconManager.region.notifyEntryStateOnDisplay = true
        
        locationManager.delegate = self
    }
    
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        currentAvailableBeacons = beacons 
        allKnownBeacons += beacons 

        NotificationCenter.default.post(name: Notification.Name(rawValue: BeaconManagerDidUpdateAvailableBeacons), object: nil, userInfo: ["beacons":beacons])
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
    }
    
}
