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
    
    var messageRecipient : User!
    var thisUser:User = User.currentUser()
    var lastMessagePostedBy:String?
    
    
//    override init(style: UITableViewStyle) {
//        super.init(style: style)
////        self.parseClassName = Messages.parseClassName()
//    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.parseClassName = Messages.parseClassName()

    }
    
    override init(className Messages: String!) {
        super.init(className: Messages)
        
        self.parseClassName = Messages
//        self.textKey = "message"
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
        var messageCounter:Int = 0
        
    
        if message.senderName == thisUser.username {
            //deque a sent message cell
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIDMessageSent) as MessageTableViewCell?
            cell?.messageTextLabel.text = message.message
            if message.senderName != lastMessagePostedBy{
                if let profileimageFile = thisUser.profileImage{
                    cell?.profileImageView.image = UIImage(data: profileimageFile.getData())
                    cell?.chatBubbleTail.hidden = false

                } else {
                    cell?.profileImageView.image = UIImage(named: "person")
                    cell?.chatBubbleTail.hidden = false

                }
            } else {
                //this message is chained - hide word bubble & adjust cell height
                cell?.chatBubbleTail.hidden = true
            }
            lastMessagePostedBy = message.senderName
            return cell
        } else {
            //deque a recieved message cell
            var cell = tableView.dequeueReusableCellWithIdentifier(cellIDMessageRecieved) as MessageTableViewCell?
            cell?.messageTextLabel.text = message.message
            
            if message.senderName != lastMessagePostedBy {
                let profileImageQuery:PFQuery = PFQuery(className:"_User")
                profileImageQuery.whereKey("username", equalTo: messageRecipient.username)
                profileImageQuery.findObjectsInBackgroundWithBlock({(stuff:[AnyObject]!, error:NSError!) -> Void in
                        if let user = stuff.first as? User{
                            if let userProfileImageFile = user.profileImage{
                                if let imageData = userProfileImageFile.getData() {
                                    dispatch_async(dispatch_get_main_queue(),{
                                        cell?.profileImageView.image = UIImage(data: imageData)
                                        cell?.chatBubbleTail.hidden = false
                                        return
                                    });
                                }
                                
                            }
                        } else {
                            cell?.profileImageView.image = UIImage(named: "person")
                            cell?.chatBubbleTail.hidden = false
                        }
                    
                })
            } else {
                cell?.chatBubbleTail.hidden = true
            }
            lastMessagePostedBy = message.senderName
            return cell
        }
        //if this is the first cell from a given user attach a profile image
//        var queryUserProfileImage


        
        
//        cell?.senderLabel.text = message.senderName

        
    }


}
