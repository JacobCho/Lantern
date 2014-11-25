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
    let lighthouseLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 49.2821103475302, longitude: -123.108108533195)

    func startTracking(manager: CLLocationManager!){
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()

            
        }
    }
    
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            println("updated location manager status")
            
            if status == CLAuthorizationStatus.Authorized {
                
                let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString:"f7826da6-4fa2-4e98-8024-bc5b71e0893e"), identifier: "workRoom")
                manager.startRangingBeaconsInRegion(beaconRegion)
                
                manager.startUpdatingLocation()
                let range:CLLocationDistance = 20
                let lighthouseRegion = CLCircularRegion(center: lighthouseLocation, radius: range, identifier: "lighthouseBuilding")
                manager.startMonitoringForRegion(lighthouseRegion)
                
            } else if status == .Denied {
                //TODO: show allert that location services wont be working
            }
    }
    
    
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("did enter region")
        if region.identifier == "ligthouseBuilding"{
            println("in the launch academy building")
        
        } else if region.identifier == "lighthouseWorkArea" {
            println("in the lighthouse work area")
            
        }
        
    }
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
         println("doing something with this region")
        if state == CLRegionState.Inside {
            println("YOU ARE THERE!")
            
        }
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var currentLocation:CLLocation = locations[0] as CLLocation
        
        println("updated location!:\(currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)")
        
    
    }
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
    }
    
    
    
    
}
