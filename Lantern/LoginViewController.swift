//
//  LoginViewController.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-17.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import Foundation
import UIKit
import Parse


class LoginViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lightImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        
        var notification = UILocalNotification()
        notification.alertBody = "Test"
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // If user is logged in, go to collection view
        if let user = User.currentUser() {
            self.performSegueWithIdentifier("loginSegue", sender: self)
        }
        
        self.fadeLight()
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        // Check if textfields are not empty
        if self.usernameTextField.text != nil && self.passwordTextField.text != nil {
            
            PFUser.logInWithUsernameInBackground(self.usernameTextField.text, password: self.passwordTextField.text, block: { (user: PFUser!, error: NSError!) -> Void in
                if user != nil {
                    // If successful login
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                    // Clear out textfields
                    self.usernameTextField.text = nil
                    self.passwordTextField.text = nil
                } else {
                    // If login unsuccessful
                    var loginErrorAlert = SCLAlertView()
                    loginErrorAlert.showError(self, title: "Error", subTitle: "There was a problem logging in", closeButtonTitle: "Ok", duration: 0)
                
                }
            })
            
        }
        // If textfields are empty show alert
        else {
            var incompleteAlert = SCLAlertView()
            incompleteAlert.showError(self, title: "Could Not Log In", subTitle: "Please fill out all textfields", closeButtonTitle: "Ok", duration: 0)
        }
        
    }
    
    /* UITextFieldDelegate method */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == self.usernameTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        return true
    }
    
    func spinLight() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.fromValue = 0
        animation.toValue = 2 * M_PI
        animation.repeatCount = MAXFLOAT
        animation.duration = 5
        
        self.lightImageView.layer.addAnimation(animation, forKey: "rotation")
        
        var transform:CATransform3D = CATransform3DIdentity
        transform.m34 = 1.0/500.0
        self.lightImageView.layer.transform = transform

    }
    
    func fadeLight() {
        self.lightImageView.alpha = 1
        self.titleLabel.alpha = 1
        UIView.animateWithDuration(2.0, delay: 0.1, options: UIViewAnimationOptions.Repeat, animations: { () -> Void in
            self.lightImageView.alpha = 0
            self.titleLabel.alpha = 0
            }) { (flag: Bool) -> Void in
                UIView.animateWithDuration(2.0, animations: { () -> Void in
                    self.lightImageView.alpha = 1
                })
        }
        
    }
    
    
}