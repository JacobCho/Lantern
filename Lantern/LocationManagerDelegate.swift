//
//  LocationManagerDelegate.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/24/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate  {
    let lighthouseLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 49.2818768, longitude: -123.1082173)

    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            println("updated location manager status")
            if status == CLAuthorizationStatus.Authorized {
//                let beaconRegion = CLBeaconRegion(proximityUUID: <#NSUUID!#>, identifier: <#String!#>)
//                manager.startRangingBeaconsInRegion(<#region: CLBeaconRegion!#>)
                manager.startUpdatingLocation()
                let range:CLLocationDistance = 20
                let lighthouseRegion = CLCircularRegion(center: lighthouseLocation, radius: range, identifier: "lighthouseBuilding")
                manager.startMonitoringForRegion(lighthouseRegion)
            } else if status == .Denied {
                //TODO: show allert that location services wont be working
            }
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        if region.identifier == "ligthouseBuilding"{
        
        } else if region.identifier == "lighthouseWorkArea" {
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
    }
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
    }
    
    
    
    
}
