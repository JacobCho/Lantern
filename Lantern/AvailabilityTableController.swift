//
//  AvailabilityTableController.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/25/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class AvailabilityTableController: UIViewController, UITableViewDelegate, NSObjectProtocol, UIScrollViewDelegate, UITableViewDataSource {

    lazy var lighthouseClass = []
    let listButton:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.locationLabel.text = "is working in \(userEntry.room?)"
        let now = NSDate(timeIntervalSinceNow: 0)
        let dateInterval = NSDateIntervalFormatter()
        dateInterval.dateStyle = .ShortStyle
        dateInterval.timeStyle = .ShortStyle
        
        if let workStartedDate = userEntry.workingSince {
        cell.timeLabel.text = dateInterval.stringFromDate(workStartedDate, toDate: now)
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
