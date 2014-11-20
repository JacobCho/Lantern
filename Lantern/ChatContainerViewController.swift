//
//  ChatContainerViewController.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-19.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class ChatContainerViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var chatTextField: UITextField!
    var messageRecipient: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatTextField.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    /* UITextFieldDelegate Method */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func sendButtonPressed(sender: UIButton) {
        var currentUser = User.currentUser()
        
        var message = Messages()
        message.message = self.chatTextField.text
//        message.user = currentUser
        message.senderId = currentUser.objectId
        message.senderName = currentUser.username
        message.recipientId = messageRecipient.objectId
        message.saveInBackgroundWithTarget(nil, selector: nil)
        
        // Push Notification to message recipient
        pushMessageToUser(messageRecipient.username, andMessage: message.message)
        
        self.chatTextField.text = nil
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "messagesEmbed" {
            var messageTableController: MessageTableViewController = segue.destinationViewController as MessageTableViewController
            messageTableController.messageRecipient = messageRecipient
            
        }
    }
}
