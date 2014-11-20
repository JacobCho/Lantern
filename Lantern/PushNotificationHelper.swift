//
//  PushNotificationHelper.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-20.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import Foundation
import Parse

func pushMessageToUser(userName : String, andMessage message : String) {
    var push : PFPush!
    push.setChannel(userName)
    push.setMessage(message)
    push.sendPushInBackgroundWithTarget(nil, selector: nil)
    
}
