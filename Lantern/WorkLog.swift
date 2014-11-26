//
//  WorkLog.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/26/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import Parse
import Foundation


class WorkLog: PFObject, PFSubclassing {
    class func parseClassName() -> String! {
        return "WorkLog"
    }
    
    override class func load() {
        self.registerSubclass()
    }
    
    @NSManaged var user: String
    @NSManaged var room: String
    @NSManaged var startTime: NSDate

}
