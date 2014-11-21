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
    
    @IBOutlet var containerView: UIView!
    
    var messageRecipient: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatTextField.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewSlide:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "viewSlide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    /* UITextFieldDelegate Method */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBOutlet var constraintToBottom: NSLayoutConstraint!
    
    
    func viewSlide(notification:NSNotification) {
    
        println("we got a notification")
        if let keyboardInfo:Dictionary = notification.userInfo {
            if notification.name == UIKeyboardWillShowNotification {
                
                
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.constraintToBottom.constant += (keyboardInfo[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue().height
                    self.view.layoutIfNeeded()
                    return
                })
                
            } else if notification.name == UIKeyboardWillHideNotification {
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.constraintToBottom.constant -= (keyboardInfo[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue().height
                    self.view.layoutIfNeeded()

                    return
                })
            }
//        UIView.commitAnimations()
        }
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.chatTextField.resignFirstResponder()

    }
    @IBAction func sendButtonPressed(sender: UIButton) {
        var currentUser = User.currentUser()
        
        var message = Messages()
        if !self.chatTextField.text.isEmpty{
        message.message = self.chatTextField.text
        message.senderId = currentUser.objectId
        message.senderName = currentUser.username
        message.recipientId = messageRecipient.objectId
        message.saveInBackgroundWithTarget(nil, selector: nil)
    
        // Push Notification to message recipient
        pushMessageToUser(messageRecipient.username, andMessage: message.message)
        
        self.chatTextField.text = nil
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "messagesEmbed" {
            var messageTableController: MessageTableViewController = segue.destinationViewController as MessageTableViewController
            messageTableController.messageRecipient = messageRecipient
            
        }
    }
}
