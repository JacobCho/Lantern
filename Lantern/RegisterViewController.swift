//
//  RegisterViewController.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-17.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import Foundation
import UIKit
import Parse

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet var pictureImageView: UIImageView!
    
    var user = User()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.delegate = self;
        self.emailTextField.delegate = self;
        self.passwordTextField.delegate = self;
        self.confirmPasswordTextField.delegate = self;
        
        // User default set (user is a iOS Student)
        user.isIosStudent = true
        user.isIosTA = false
        user.isWebStudent = false
        user.isWebTA = false
    }
    
    
    @IBAction func registerButtonPressed(sender: UIButton) {
        self.checkFieldsComplete()
        
    }
    
    /* Register Helper Methods */
    func checkFieldsComplete() {
        // Check if textfields are empty
        if self.usernameTextField.text.isEmpty || self.emailTextField.text.isEmpty || self.passwordTextField.text.isEmpty || self.confirmPasswordTextField.text.isEmpty {
            // Show Alert
            var incompleteAlert = UIAlertController(title: "Could Not Log In", message: "Please fill out all textfields", preferredStyle: UIAlertControllerStyle.Alert)
            incompleteAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(incompleteAlert, animated: true, completion: nil)
            
        } else {
            self.checkPasswordsMatch()
        }
    }
    
    func checkPasswordsMatch() {
        if self.passwordTextField.text == self.confirmPasswordTextField.text {
            self.registerUser()
        }
        else {
            // Show Alert
            var passwordsAlert = UIAlertController(title: "Could Not Log In", message: "Your passwords do not match", preferredStyle: UIAlertControllerStyle.Alert)
            passwordsAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(passwordsAlert, animated: true, completion: nil)

        }
    }
    
    func registerUser() {
        user.username = self.usernameTextField.text!
        user.email = self.emailTextField.text!
        user.password = self.passwordTextField.text
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                println(error)
            }
        }
    }
    
    @IBAction func studentTeacherControlChanged(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            user.isIosStudent = true
            user.isIosTA = false
            user.isWebStudent = false
            user.isWebTA = false
        } else if sender.selectedSegmentIndex == 1 {
            user.isIosTA = true
            user.isIosStudent = false
            user.isWebStudent = false
            user.isWebTA = false
        } else if sender.selectedSegmentIndex == 2 {
            user.isWebStudent = true
            user.isIosStudent = false
            user.isIosTA = false
            user.isWebTA = false
        } else if sender.selectedSegmentIndex == 3 {
            user.isWebTA = true
            user.isIosStudent = false
            user.isIosTA = false
            user.isWebStudent = false;
        }
    }


    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /* UITextFieldDelegate method */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
