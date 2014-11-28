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
    
    // Initialize Beacons
    let workRoomBeacon : Beacon = Beacon(identifier: "5r b0", UUID: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E", majorValue: 1964, minorValue: 44674)
    let lamainBeacon : Beacon = Beacon(identifier: "FBcc", UUID: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E", majorValue: 44898, minorValue: 64346)
    let kitchenBeacon : Beacon = Beacon(identifier: "ico1", UUID: "F7826DA6-4FA2-4E98-8024-BC5B71E0893E", majorValue: 309, minorValue: 33838)
    
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
            println("updated location manager status")
            
            if status == CLAuthorizationStatus.Authorized {
                
                let beaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString:workRoomBeacon.UUID), identifier: "Lighthouse")
                manager.startRangingBeaconsInRegion(beaconRegion)
                
//                manager.startUpdatingLocation()
//                let range:CLLocationDistance = 20
//                let lighthouseRegion = CLCircularRegion(center: lighthouseLocation, radius: range, identifier: "lighthouseBuilding")
//                manager.startMonitoringForRegion(lighthouseRegion)
                
            } else if status == .Denied {
                //TODO: show allert that location services wont be working
            }
    }
    
    
    

    
//    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
//        
//    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var currentLocation:CLLocation = locations[0] as CLLocation
        
//        println("updated location!:\(currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)")
        
    
    }
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        var currentUser:User? = User.currentUser()
        
        if currentUser != nil {
            
            // If User is a TA, set to working when in beacon range
            if currentUser!.isTeacher() {
                
                if !currentUser!.isWorking {
                    currentUser!.isWorking = true
                    currentUser!.saveInBackgroundWithTarget(nil, selector: nil)

                        var workingAlert = RKDropdownAlert.title("In Beacon range", message: "You are set to working status")

                    
                }
            }
        
            for beacon in beacons {
                if workRoomBeacon.isEqualToBeacon(beacon as CLBeacon) {
//                    println("Found work room beacon")
                    if currentUser!.room != RoomNames.LHMain {
                        
                        currentUser?.updatedAt
                        currentUser!.room = RoomNames.LHMain
                        currentUser!.saveInBackgroundWithTarget(nil, selector: nil)
                        if beacon.proximity == CLProximity.Near {
                            var workRoomAlert = RKDropdownAlert.title("Room Change", message: "You are now in the Lighthouse Labs main work room")
                        }
                        
                    }
                    
//                    switch beacon.proximity! {
//                    case CLProximity.Far:
//                        println("You are in far proximity")
//                    case CLProximity.Near:
//                        println("You are in near proximity")
//                    case CLProximity.Immediate:
//                        println("You are in immediate proximity")
//                    case CLProximity.Unknown:
//                        println("cant tell how far away you are")
//                    
//                        return
//                    }
                }
                
                if kitchenBeacon.isEqualToBeacon(beacon as CLBeacon) {
//                    println("Found kitchen beacon")
                    if currentUser!.room != RoomNames.Kitchen {
                        currentUser!.room = RoomNames.Kitchen
                        currentUser!.saveInBackgroundWithTarget(nil, selector: nil)
                        if beacon.proximity == CLProximity.Near  {
                            var kitchenAlert = RKDropdownAlert.title("Room Change", message: "You are now in the kitchen")
                        }
                    }
                    
                }
                
                if lamainBeacon.isEqualToBeacon(beacon as CLBeacon) {
//                    println("Found LA main beacon")
                    if currentUser!.room != RoomNames.LAMain {
                        currentUser!.room = RoomNames.LAMain
                        currentUser!.saveInBackgroundWithTarget(nil, selector: nil)
                        if beacon.proximity == CLProximity.Near {
                            var launchAcademyAlert = RKDropdownAlert.title("Room Change", message: "You are now in the Launch Academy main room")
                        }
                    }
                    
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
