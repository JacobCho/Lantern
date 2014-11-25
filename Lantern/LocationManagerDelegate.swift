//
//  LocationManagerDelegate.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/24/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate  {
   
    optional func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus){
        println("you did something!")
            
            
    }
    
    
    
    
}
