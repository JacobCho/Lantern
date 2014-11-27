//
//  ProfileViewController.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/23/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var nameTextLabel: UILabel!
    @IBOutlet var profileImageView: PFImageView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var pictureButton:UIButton!
    
    var userForProfile:User = User()
    
    var userWorkLogs:Array<WorkLog> = []
    
    @IBAction func pictureButtonPress(sender: AnyObject) {
        
    }
    @IBAction func escapePress(sender: AnyObject) {
                self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userForProfile.objectId == User.currentUser().objectId {
            self.makePictureButton(true)
        } else {
            self.makePictureButton(false)
        }
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2
        self.profileImageView.clipsToBounds = true
        
        self.profileImageView.file = userForProfile.profileImage
        self.profileImageView.loadInBackground(nil)
        self.view.sendSubviewToBack(self.tableView)
        
        self.queryForWorkLog()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.userWorkLogs.count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("workLogEntry", forIndexPath: indexPath) as RoomTableViewCell
        let entry = self.userWorkLogs[indexPath.row]
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        

        
        let date = formatter.stringFromDate(entry.updatedAt)
        
        cell.nameLabel.text = date
        cell.locationLabel.text = "working in the \(entry.room)"
        
        cell.timeLabel.text = "for \(entry.time.integerValue/60) minutes"
//        let timeFormatter = NSNumberFormatter()
//        timeFormatter.maximumFractionDigits = 2
//        timeFormatter.stringFromNumber(entry.time.integerValue/60)

        

        // Configure the cell...

        return cell
    }
    
    func queryForWorkLog() {
        let query:PFQuery = PFQuery(className: WorkLog.parseClassName())
        query.whereKey("user", equalTo: userForProfile)
        query.findObjectsInBackgroundWithBlock { (results:[AnyObject]!, error:NSError!) -> Void in
            
            self.userWorkLogs = results as [WorkLog]
            println("downloaded work logs for \(self.userForProfile.username)")
            self.tableView.reloadData()
            
        }
        
    }

    func makePictureButton(visible:Bool){
        if visible{
        self.pictureButton.hidden = false
        self.pictureButton.userInteractionEnabled = true
        } else if !visible {
            self.pictureButton.hidden = true
            self.pictureButton.userInteractionEnabled = false
        }
    }

}
