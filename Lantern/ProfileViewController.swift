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
    
    var userForProfile:User = User()
    
    var userWorkLogs:Array<WorkLog> = []
    
    
    

    @IBAction func pictureButtonPress(sender: AnyObject) {
        
    }
    @IBAction func escapePress(sender: AnyObject) {
                self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2
        self.profileImageView.clipsToBounds = true

        self.profileImageView.file = userForProfile.profileImage
        self.profileImageView.loadInBackground(nil)
        self.view.sendSubviewToBack(self.tableView)
        
        self.queryForWorkLog()
//        self.profileImageView.sendSubviewToBack(self.profileImageView)
    
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
        cell.nameLabel.text = "\(entry.updatedAt)"
        cell.locationLabel.text = entry.room
        cell.timeLabel.text = "working for \(entry.time)"
        

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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
