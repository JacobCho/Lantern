//
//  AvailabilityTableController.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/25/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class AvailabilityTableController: UIViewController, UITableViewDelegate, NSObjectProtocol, UIScrollViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView:UITableView!
    
    lazy var lighthouseClass = []
    let listButton:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 100.0;
        
    }
    

    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return self.lighthouseClass.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let thisSection: AnyObject = lighthouseClass[section]
        return thisSection.count
    }
    
    @IBAction func collectionViewButtonPress(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonEntry", forIndexPath: indexPath) as RoomTableViewCell
        let thisSection = lighthouseClass[indexPath.section]
        let userEntry = thisSection[indexPath.row] as User
        
        cell.nameLabel.text = userEntry.username
        if userEntry.isWorking {
            if let workroom = userEntry.room {
                cell.locationLabel.text = "has been working in \(userEntry.room!)"
                if workroom == "" {
                    cell.locationLabel.text = "has been working out beacon range"
                }
            } else {
                cell.locationLabel.text = "has been working out beacon range"

            }
            let now = NSDate(timeIntervalSinceNow: 0)
            if let workStartedDate = userEntry.workingSince {
                let timeWorking:NSTimeInterval = now.timeIntervalSinceDate(workStartedDate)
                if timeWorking > 60 && timeWorking < 3600 {
                    cell.timeLabel.text = " for \(timeWorking/60) minutes"
                } else if timeWorking > 360 {
                    let hourStr = NSString(format: "%.2f", timeWorking/3600)
                    cell.timeLabel.text = " for \(hourStr) hours"

                } else {
                    cell.timeLabel.text = " for \(timeWorking/1) seconds"

                }
            }
        } else {
            cell.locationLabel.text = "is not working right now"
            cell.locationLabel.textColor = UIColor(red: 1, green: 0.1, blue: 0.1, alpha: 1)
            cell.timeLabel.text = ""
        }
        
        // Configure the cell...tab
        
        return cell
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
