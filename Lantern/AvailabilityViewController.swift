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
    
    var timer:NSTimer?
    
    lazy var lighthouseClass = []
    
    
    var thisUser:User = User.currentUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        self.collectionView!.dataSource = self
        self.queryForClass()
        if thisUser.isIosStudent || thisUser.isIosTA {
            self.title = "\(thisUser.username) - iOS cohort"
        } else if thisUser.isWebStudent || thisUser.isWebTA {
            self.title = "\(thisUser.username) Web cohort"
        }
        var workingButton:UIBarButtonItem = UIBarButtonItem(title: "Working", style: .Plain , target: self, action: "changeWorkStatus")
        
        self.navigationItem.rightBarButtonItem = workingButton
        self.addListButton()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startCheckingForStatusUpdates()
    }
    
    @IBAction func logoutButtonPress(sender: UIBarButtonItem) {
        
        //TODO: alert user to confirm that they want to log out
        self.navigationController?.popToRootViewControllerAnimated(true)
        User.logOut()
    }
    
    
    func changeWorkStatus (){
        if thisUser.isWorking == true {
            thisUser.isWorking = false
            if let startedWorking = thisUser.workingSince? {
                let now = NSDate(timeIntervalSinceNow: 0)
                let log = WorkLog()
                log.user = thisUser
                if let room = thisUser.room{
                    log.room = room
                }
                log.time = now.timeIntervalSinceDate(startedWorking)
                log.saveInBackgroundWithBlock(nil)
                
                thisUser.workingSince = nil
            }
            
        } else if thisUser.isWorking == false {
            thisUser.isWorking = true
            thisUser.workingSince = NSDate(timeIntervalSinceNow: 0)
        } else {
            thisUser.isWorking = true
            thisUser.workingSince = NSDate(timeIntervalSinceNow: 0)
        }
        
        thisUser.saveInBackgroundWithBlock {(success:Bool, error:NSError!) -> Void in
            if error != nil {
                println("error! \(error)")
            }
            if success {
                println("saved user is working \(self.thisUser.isWorking)")
            }
        }
        
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.lighthouseClass.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var thisSection:AnyObject = lighthouseClass[section]
        return thisSection.count
    }

//    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//        let sectionHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "sectionHeader", forIndexPath: indexPath)
////        sectionHeader.headerTitleLabel.text = "Section"
//
//        return sectionHeader as UICollectionReusableView
//    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("personCell", forIndexPath: indexPath) as PersonCell
        
        let thisSection: Array = lighthouseClass[indexPath.section] as Array <User>
        let thisPerson: User! = thisSection[indexPath.row] as User
        
        cell.imageView.image = UIImage(named: "person")
        cell.imageView.file = thisPerson.profileImage?
        cell.imageView.loadInBackground(nil)
        
        if thisPerson.isWorking {
            cell.alpha=1
            cell.userInteractionEnabled = true
            cell.addPulses(2.6)
        } else {
            cell.alpha=0.5
            cell.userInteractionEnabled = false
        }
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
        cell.imageView.clipsToBounds = true
        
        cell.nameLabel.text = thisPerson.username
        cell.person = thisPerson!
        
        return cell

    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as PersonCell
        if cell.person.objectId == thisUser.objectId {
            self.performSegueWithIdentifier("showProfile", sender: (collectionView.cellForItemAtIndexPath(indexPath)))

        } else {
            self.performSegueWithIdentifier("findSelected", sender: (collectionView.cellForItemAtIndexPath(indexPath)))
        }
        
    }
//if a user taps a cell they will be taken to the finder view for that person - set the desitination view to the appropriate user
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "findSelected" {
            var finderView:FinderViewController = segue.destinationViewController as FinderViewController
            var tappedCell = sender as PersonCell
            finderView.userToBeFound = tappedCell.person
        } else if segue.identifier == "showProfile" {
            var profileView:ProfileViewController = segue.destinationViewController as ProfileViewController
            profileView.userForProfile = thisUser
            
        } else if segue.identifier == "timeTable" {
            var roomView:AvailabilityTableController = segue.destinationViewController as AvailabilityTableController
            roomView.lighthouseClass = self.lighthouseClass
        }

        
}
    
    func addListButton(){
        let listButton:UIButton = UIButton()
        listButton.layer.anchorPoint = CGPointMake(1, 1)
        listButton.frame = CGRectMake(self.view.frame.width-100, self.view.frame.height-30, 100, 60)
        listButton.addTarget(self, action: "peopleButtonPress:", forControlEvents: UIControlEvents.TouchUpInside)
        
        listButton.setImage(UIImage(named: "peopleIcon_1x"), forState: .Normal)
//        listButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.view.addSubview(listButton)

//        self.view.sendSubviewToBack(self.collectionView!)
    }
    func peopleButtonPress(sender:UIButton){
        self.performSegueWithIdentifier("timeTable", sender: nil)
        
    }

//We need to query parse for the relevant users to display
    func queryForClass(){
        
        var query = PFQuery(className: "_User")
        
        if thisUser.isIosStudent || thisUser.isIosTA {
            
            let studentsQuery = PFQuery(className: "_User")
            studentsQuery.whereKey("isIosStudent", equalTo: true)
            
            let teachersQuery = PFQuery(className: "_User")
            teachersQuery.whereKey("isIosTA", equalTo: true)
            
            query = PFQuery.orQueryWithSubqueries([studentsQuery,teachersQuery])
        }   else if thisUser.isWebStudent || thisUser.isWebTA {
            
            let studentsQuery = PFQuery(className: "_User")
            studentsQuery.whereKey("isWebStudent", equalTo: true)
            
            let teachersQuery = PFQuery(className: "_User")
            teachersQuery.whereKey("isWebTA", equalTo: true)
            
            query = PFQuery.orQueryWithSubqueries([studentsQuery,teachersQuery])
        }
        query.selectKeys(["username","isIosStudent","isIosTA","isWebStudent","isWebTA","profileImage","isWorking","room"])
        
        query.findObjectsInBackgroundWithBlock { (results:[AnyObject]!, error:NSError!) -> Void in
            if (error == nil) {

                var index:Int
                var teachers:[User] = []
                var students:[User] = []
                var me:[User] = []

                for index = 0; index < results.count; ++index {
                    
                    let aPerson:User! = results[index] as User
                    if aPerson.objectId == self.thisUser.objectId{
                        me.append(aPerson)
                    } else if aPerson.isWebTA || aPerson.isIosTA {
                        teachers.append(aPerson)
                    } else if aPerson.isIosStudent || aPerson.isWebStudent {
                        students.append(aPerson)
                    }
                }
                self.lighthouseClass = [teachers,students,me]
                
                self.collectionView!.reloadData()

            } else {
                println("NOT GOOD\(error)")
            }
        }
    }

    
    //MARK: - status updates on timer
    func startCheckingForStatusUpdates(){
        timer = NSTimer.scheduledTimerWithTimeInterval(globalConst.updateSpeed, target: self, selector: Selector("queryForClass"), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        timer?.invalidate()
    }
    
}
