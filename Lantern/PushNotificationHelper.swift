//
//  PushNotificationHelper.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-20.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import Foundation
import Parse

    func pushMessageToUser(userName : String, andMessage message : String, withSenderName senderName : String) {
    
        var push : PFPush = PFPush()
        push.setChannel(userName)
        push.setMessage(senderName + ": " + message)
        push.sendPushInBackgroundWithTarget(nil, selector: nil)
        
    }

    func handlePushMessage(message : String) -> User {
        
        var userName : String = ""
        var user : User = User()
        
        // Added all the letters to userName from message before message gets to ":"
        for letter in message {
            
            if letter == ":" {
                break
            }
            
            else {
                userName.append(letter)
            }
            
        }
        
        // query for username
        var query : PFQuery = User.query()
        query.whereKey("username", equalTo: userName)
        query.findObjectsInBackgroundWithBlock { (users: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
            var user: User = users[0] as User
                println(user.username)
                
            }
            
        }
        return user
    }
