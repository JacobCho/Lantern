//
//  MapOverlay.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/25/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class MapOverlay: NSObject {

    let roomName:String
    let roomOrigin:CGPoint
    let overlayView:UIImageView
    
     init(roomName:String, mapOrigin:CGPoint, overlayView: UIImageView) {
        self.roomName = roomName
        self.roomOrigin = mapOrigin
        self.overlayView = overlayView
    }
   
}
