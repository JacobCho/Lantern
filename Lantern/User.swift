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
    @NSManaged var students: PFRelation
    @NSManaged var teachers: PFRelation
    
    func setRelations(user: User) {
        
        if (user.isIosStudent) {
            // query for users who are ios teachers
            var teacherQuery = PFQuery(className: "User")
            teacherQuery.whereKey("isIosTA", lessThanOrEqualTo: true)
            teacherQuery.findObjectsInBackgroundWithBlock({ (teachers: [AnyObject]!, error:NSError!) -> Void in
                if (error != nil) {
                    // set relationship for student with those teachers
                    for teacher in teachers {
                        var relation = user.relationForKey("teachers")
                        relation.addObject(user)
                        user.saveInBackgroundWithBlock(nil)
                    }
                }
            })
        }
        
        else if (user.isIosTA) {
            // query for users who are ios students
            var studentQuery = PFQuery(className: "User")
            studentQuery.whereKey("isIosStudent", lessThanOrEqualTo: true)
            studentQuery.findObjectsInBackgroundWithBlock({ (students:[AnyObject]!, error: NSError!) -> Void in
                if (error != nil) {
                    // set relationship for teacher with those students
                    for student in students {
                        var relation = user.relationForKey("students")
                        relation.addObject(user)
                        user.saveInBackgroundWithBlock(nil)
                    }
                    
                }
            })
        }
        
        else if (user.isWebStudent) {
            // query for users who are web teachers
            var teacherQuery = PFQuery(className: "User")
            teacherQuery.whereKey("isWebTA", lessThanOrEqualTo: true)
            teacherQuery.findObjectsInBackgroundWithBlock({ (teachers: [AnyObject]!, error: NSError!) -> Void in
                if (error != nil) {
                    
                }
            })
            
        }
        
    }


}
