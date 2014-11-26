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
        
//        self.addListButton()
        
    
    }
    
//    func addListButton(){
//        
//        listButton.layer.anchorPoint = CGPointMake(1, 1)
//        listButton.frame = CGRectMake(self.view.frame.width-100, self.view.frame.height-60, 100, 60)
//        listButton.addTarget(self, action: "peopleButtonPress:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        listButton.setImage(UIImage(named: "peopleIcon_1x"), forState: .Normal)
//        
//        self.view.addSubview(listButton)
//        
//    }
//    
//    func peopleButtonPress(sender:UIButton){
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.lighthouseClass.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        let thisSection: AnyObject = lighthouseClass[section]
        return thisSection.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personTableEntry", forIndexPath: indexPath) as RoomTableViewCell
        let thisSection = lighthouseClass[indexPath.section]
        let thisUser = thisSection[indexPath.row] as User
        
        cell.nameLabel.text = thisUser.username
        cell.locationLabel.text = thisUser.room?
        
        
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
