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
    
    var thisUser:User = User.currentUser()
    
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
    override func queryForTable() -> PFQuery! {
        var query : PFQuery!
        
        query = Messages.query()
        query.whereKey("senderName", containsString: User.currentUser().username)
        
        if messageRecipient != nil {
            // Add query for recipients
            var recipientQuery = Messages.query()
            recipientQuery.whereKey("recipientId", containsString: messageRecipient.objectId)
            
            //Add subquery to main query
            query = PFQuery.orQueryWithSubqueries([recipientQuery])
        }
        
        return query
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        
        var cellIDMessageRecieved = "messageCellYou"
        var cellIDMessageSent = "messageCellMe"
        var message = object as Messages
    
        if message.senderName == thisUser.username {
            //deque a sent message cell
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIDMessageSent) as MessageTableViewCell?
            cell?.messageTextLabel.text = message.message
            
            return cell
        } else {
            //deque a recieved message cell
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIDMessageRecieved) as MessageTableViewCell?
            cell?.messageTextLabel.text = message.message
            cell?.imageView.file = message.user.profileImage
                        
            return cell
        }


        
        
//        cell?.senderLabel.text = message.senderName

        
    }


}
