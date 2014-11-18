//
//  AvailabilityViewController.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/17/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import Parse

class AvailabilityViewController: UICollectionViewController {
    
    var peopleInGroup:Array<User> = []
    var thisUser:User = User.currentUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        self.collectionView!.dataSource = self

    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
//        return peopleInGroup.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("personCell", forIndexPath: indexPath) as PersonCell
        cell.imageView.image = UIImage(named: "person")
        cell.nameLabel.text = "Name"
        cell.person = peopleInGroup[indexPath.row] as User
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("findSelected", sender: (collectionView.cellForItemAtIndexPath(indexPath)))
        
    }
    
    
//if a user taps a cell they will be taken to the finder view for that person - set the desitination view to the appropriate user
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var finderView:FinderViewController = segue.destinationViewController as FinderViewController
        var tappedCell = sender as PersonCell
        
        finderView.userToBeFound = tappedCell.person
        
        
//        segue.destinationViewController
    }
    
    
//We need to query parse for the relevant users to display
    func queryForCoorespondingUsers(){
        
        var query = PFQuery(className: "_User")
        if thisUser.isIosStudent || thisUser.isWebStudent {
            query.valueForKey("teachers")
        }
        if thisUser.isWebTA || thisUser.isIosTA{
            query.valueForKey("students")
        }
        
        query.findObjectsInBackgroundWithBlock { (users:[AnyObject]!, error:NSError!) -> Void in
            if (error != nil) {
                self.peopleInGroup = users as [User]
                println("got some users! \(self.peopleInGroup.count) results")
            } else {
                NSLog("error:%@", error)
            }
        }
    }
}
