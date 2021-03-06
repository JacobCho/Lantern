//
//  MessageTableViewController.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-19.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import Parse

private struct Constants {
    static let cellIDMessageRecieved = "messageCellYou"
    static let cellIDMessageSent = "messageCellMe"
}

class MessageTableViewController: PFQueryTableViewController {
    
    var messageRecipient : User!
    var thisUser:User = User.currentUser()
    var lastMessagePostedBy:String?
    var timer:NSTimer?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parseClassName = Messages.parseClassName()
    }
    
    override init(className Messages: String!) {
        super.init(className: Messages)
        self.parseClassName = Messages
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.startCheckingForNewMessages()

        
    }
// MARK: parse query stuff
    
    override func queryForTable() -> PFQuery! {
        var query : PFQuery!
        
        // Query if I'm the sender
        var senderQuery = Messages.query()
        senderQuery.whereKey("recipientId", containsString: messageRecipient.objectId)
        senderQuery.whereKey("senderName", containsString: User.currentUser().username)
        
        // Query if sender is messageRecipient
        var selfRecipientQuery = Messages.query()
        selfRecipientQuery.whereKey("recipientId", containsString:User.currentUser().objectId)
        selfRecipientQuery.whereKey("senderName", containsString:messageRecipient.username)
        
        //Add subquery to main query
        query = PFQuery.orQueryWithSubqueries([senderQuery, selfRecipientQuery])
        query.orderByAscending("createdAt")
        
        return query
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        if let message = object as? Messages{
            var messageCounter:Int = 0
            var cell:MessageTableViewCell!
            if message.senderName == thisUser.username {
                cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIDMessageSent) as MessageTableViewCell
                cell = self.configureCellForUser(cell, user: thisUser, indexPath: indexPath)
                
            } else if message.senderName == messageRecipient.username {
                //deque a recieved message cell
                cell = tableView.dequeueReusableCellWithIdentifier(Constants.cellIDMessageRecieved) as MessageTableViewCell
                cell = self.configureCellForUser(cell, user: messageRecipient , indexPath: indexPath)
            }

            cell.messageTextLabel.text = message.message
            return cell
        }
        println("NO MESSAGE FOR YOU")
        return nil

        
}

    func startCheckingForNewMessages(){
        timer = NSTimer.scheduledTimerWithTimeInterval(globalConst.updateSpeed, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    func update(){
        println("checking for some updates")
        
        self.queryForTable()
        self.loadObjects()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.timer?.invalidate()
    }
    
    func configureCellForUser(cell:MessageTableViewCell, user:User, indexPath:NSIndexPath)->MessageTableViewCell{
        cell.profileImageView.file = user.profileImage?
        cell.profileImageView.loadInBackground(nil)
        if indexPath.row > 0 {
            let previousMessage = self.objects[indexPath.row-1] as Messages
            if previousMessage.senderName == user.username{
                self.hideOrUnhideCellContent(cell, hide: true)
            }
        } else {
            self.hideOrUnhideCellContent(cell, hide: false)
        }
        return cell
    }
    
    
    func hideOrUnhideCellContent(cell:MessageTableViewCell, hide:Bool){

        cell.profileImageView.hidden = hide
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width/2
        cell.profileImageView.clipsToBounds = true
        cell.chatBubbleTail.hidden = hide

    }
    
    

}
