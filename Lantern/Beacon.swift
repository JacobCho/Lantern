//
//  Beacon.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-25.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import Foundation
import CoreLocation

class Beacon {
    
    var identifier: String
    var UUID: String
    var majorValue : CLBeaconMajorValue
    var minorValue : CLBeaconMinorValue
    
    init(identifier: String, UUID: String, majorValue : CLBeaconMajorValue, minorValue : CLBeaconMinorValue) {
        
        self.identifier = identifier
        self.UUID = UUID
        self.majorValue = majorValue
        self.minorValue = minorValue
    }
    
    func isEqualToBeacon(beacon : CLBeacon) -> Bool {
        if beacon.proximityUUID.UUIDString == self.UUID && beacon.major == self.majorValue.description.toInt()! && self.minorValue.description.toInt()! == beacon.minor {
            return true
            
        }
        else {
//            println("Don't match")
            return false
        }
    }
    
}
