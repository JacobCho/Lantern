//
//  LocationManagerDelegate.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/24/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import CoreLocation
import Parse


class LocationManagerDelegate: NSObject, CLLocationManagerDelegate  {
    let lighthouseLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 49.2821103475302, longitude: -123.108108533195)
    
    // Initialize work room beacon
    let workRoomBeacon : Beacon = Beacon(identifier: "workRoom", UUID: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E", majorValue: 1964, minorValue: 44674)
    let currentUser:User = User.currentUser()
    
    
  
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            println("updated location manager status")
            
            if status == CLAuthorizationStatus.Authorized {
                
                let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString:workRoomBeacon.UUID), identifier: workRoomBeacon.identifier)
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
        
//        println("updated location!:\(currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)")
        
    
    }
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
//        println("Got beacons! \(beacons[0])")
    
        for beacon in beacons {
            if workRoomBeacon.isEqualToBeacon(beacon as CLBeacon) {
                println("Found work room beacon")
                if currentUser.room != RoomNames.LHMain {
                    currentUser.room = RoomNames.LHMain
                    currentUser.saveInBackgroundWithBlock(nil)
                }
                
                switch beacon.proximity! {
                case CLProximity.Far:
                    println("You are in far proximity")
                case CLProximity.Near:
                    println("You are in near proximity")
                case CLProximity.Immediate:
                    println("You are in immediate proximity")
                case CLProximity.Unknown:
                    println("cant tell how far away you are")
                
                    return
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        println(error)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    
    
    
}
