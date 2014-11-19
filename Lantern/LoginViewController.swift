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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // If user is logged in, go to collection view
        let user = User.currentUser()
        if user != nil {
            if user.username != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
        }
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        // Check if textfields are not empty
        if self.usernameTextField.text != nil && self.passwordTextField.text != nil {
            
            PFUser.logInWithUsernameInBackground(self.usernameTextField.text, password: self.passwordTextField.text, block: { (user: PFUser!, error: NSError!) -> Void in
                if user != nil {
                    // If successful login
                    self.performSegueWithIdentifier("loginSegue", sender: self)
                    
                } else {
                    // If login unsuccessful
                    var loginErrorAlert = UIAlertController(title: "Error", message: "There was a problem logging in", preferredStyle: UIAlertControllerStyle.Alert)
                    loginErrorAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(loginErrorAlert, animated: true, completion: nil)
                }
            })
            
        }
        // If textfields are empty show alert
        else {
            
            var incompleteAlert = UIAlertController(title: "Could Not Log In", message: "Please fill out all textfields", preferredStyle: UIAlertControllerStyle.Alert)
            incompleteAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(incompleteAlert, animated: true, completion: nil)
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
    
    
}