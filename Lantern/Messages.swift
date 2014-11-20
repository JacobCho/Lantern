//
//  Messages.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-19.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import Foundation
import Parse

class Messages: PFObject, PFSubclassing {
    
    class func parseClassName() -> String! {
        return "Messages"
    }
    
    override class func load() {
        self.registerSubclass()
    }
    
    @NSManaged var message: String
    @NSManaged var recipientIds: Array<String>
    @NSManaged var senderId: String
    @NSManaged var senderName: String
    
}
