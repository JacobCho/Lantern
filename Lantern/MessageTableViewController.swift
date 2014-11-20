//
//  MessageTableViewController.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-19.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import Parse

class MessageTableViewController: PFQueryTableViewController {
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.parseClassName = Messages.parseClassName()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parseClassName = Messages.parseClassName()
    }
    
    override init(className Messages: String!) {
        super.init(className: Messages)
        
        self.parseClassName = Messages
        self.textKey = "message"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Filter stuff in your query
//    override func queryForTable() -> PFQuery! {
//        var query : PFQuery!
//        
//        return query
//    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        
        var cellIdentifier = "messageCell"

        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as MessageTableViewCell?
        
        var message = object as Messages
        
        cell?.senderLabel.text = message.senderName
        cell?.messageLabel.text = message.message
        
        return cell
        
    }


}
