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
    
    lazy var peopleInGroup: [User] = []
    var thisUser:User = User.currentUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        self.collectionView!.dataSource = self
        self.queryForCoorespondingUsers()
        
        var workingButton:UIBarButtonItem = UIBarButtonItem(title: "Working", style: .Plain , target: self, action: "changeWorkStatus")
        
        self.navigationItem.rightBarButtonItem = workingButton
      

    }
    
    func changeWorkStatus (){
        if thisUser.isWorking == true {
            thisUser.isWorking = false
        } else if thisUser.isWorking == false{
            thisUser.isWorking = true
        } else {
            thisUser.isWorking = true
        }
        
        thisUser.saveInBackgroundWithBlock {(success:Bool, error:NSError!) -> Void in
            if success {
                println("saved user is working \(self.thisUser.isWorking)")
            }
        }
        
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return peopleInGroup.count
    }
    
    @IBAction func logoutButtonPress(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
            User.logOut()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("personCell", forIndexPath: indexPath) as PersonCell
        
        let thisPerson:User = peopleInGroup[indexPath.row] as User
        
        if let data = thisPerson.profileImage {
           data.getDataInBackgroundWithBlock({ (imageData:NSData!, error: NSError!) -> Void in
                cell.imageView.image = UIImage(data: imageData)
            })

        } else {
            cell.imageView.image = UIImage(named: "person")
        }
        if thisPerson.isWorking {
            cell.alpha=1
            cell.userInteractionEnabled = true
        } else {
            cell.alpha=0.5
//            cell.userInteractionEnabled = false
        }
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2.6
        cell.imageView.clipsToBounds = true
        
//        cell.imageView.image = UIImage(data: thisPerson.profileImage)
        cell.nameLabel.text = thisPerson.username
        cell.person = thisPerson
        
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
        
}

    
    
//We need to query parse for the relevant users to display
    func queryForCoorespondingUsers(){
        
        var query = PFQuery(className: "_User")
        
        if thisUser.isIosStudent {
            query.whereKey("isIosTA", equalTo: true)
        }
        else if thisUser.isWebStudent {
            query.whereKey("isWebTA", equalTo: true)
        }
        else if thisUser.isIosTA {
            query.whereKey("isIosStudent", equalTo: true)
        }
        else if thisUser.isWebTA {
            query.whereKey("isWebStudent", equalTo: true)
        }
        query.selectKeys(["username","isIosTA","isWebStudent","isWebTA","profileImage","isWorking"])
        
        query.findObjectsInBackgroundWithBlock { (users:[AnyObject]!, error:NSError!) -> Void in
            if (error == nil) {
                self.peopleInGroup = users as [User]
                println("got some users! \(self.peopleInGroup.count) results")
                self.collectionView!.reloadData()

            } else {
                println("NOT GOOD\(error)")
            }
        }
    }
}
