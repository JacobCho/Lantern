//
//  User.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-17.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import Foundation
import Parse

class User: PFUser, PFSubclassing {
    
    override class func load() {
        self.registerSubclass()
    }
    
    @NSManaged var isIosStudent: Bool
    @NSManaged var isIosTA: Bool
    @NSManaged var isWebStudent: Bool
    @NSManaged var isWebTA: Bool
    @NSManaged var profileImage: NSData

}
