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

class RegisterViewController: UIViewController, UITextFieldDelegate, UIActionSheetDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var teacher: UIButton!
    
    var user = User()
    var profileImageData:NSData?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self;
        emailTextField.delegate = self;
        passwordTextField.delegate = self;
        confirmPasswordTextField.delegate = self;
        teacher.hidden = true
        pictureImageView.layer.cornerRadius = pictureImageView.frame.width/2
        pictureImageView.clipsToBounds = true
        
        
        // User default set (user is a iOS Student)
        user.isIosStudent = true
        user.isIosTA = false
        user.isWebStudent = false
        user.isWebTA = false
    }
    
    
    @IBAction func registerButtonPressed(sender: UIButton) {
        self.checkFieldsComplete()
        
    }
    @IBAction func teacherGesture(sender: UILongPressGestureRecognizer) {
        if sender.state == .Began {
            self.teacher.hidden = false
            if user.isIosStudent{
                user.isWebTA = false
                user.isIosStudent = false
                user.isIosTA = true
                user.isWebStudent = false;
            } else if user.isWebStudent {
                user.isWebTA = true
                user.isIosStudent = false
                user.isIosTA = false
                user.isWebStudent = false;
            }
        }
    }
    @IBAction func photoWasTapped(sender: UITapGestureRecognizer) {
        let photoPickerActionSheet:UIActionSheet = UIActionSheet(title: "Take new photo or use existing", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Take new photo", "Use photo from library")
        photoPickerActionSheet.showInView(self.view)
    
    }
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        println("user clicked button at index:\(buttonIndex)")
        switch buttonIndex{
        case 1:
            let newPhotoPicker:UIImagePickerController = UIImagePickerController()
            newPhotoPicker.delegate=self
            newPhotoPicker.sourceType = .Camera
            newPhotoPicker.allowsEditing = true
            self.presentViewController(newPhotoPicker, animated: true, completion: { () -> Void in
                println("opening user's camera")
            })
        case 2:
            let oldPhotoPicker:UIImagePickerController = UIImagePickerController()
            oldPhotoPicker.delegate = self
            oldPhotoPicker.sourceType = .SavedPhotosAlbum
            oldPhotoPicker.allowsEditing = true
            self.presentViewController(oldPhotoPicker, animated: true, completion: { () -> Void in
                println("opening user's saved photos")
            })
            
        default:()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            println("THIS PHOTO")
        })
        profileImageData = UIImageJPEGRepresentation(image, 0.5)
        pictureImageView.image = image
        pictureImageView.alpha = 1.0
            println("user picked a photo!")
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /* Register Helper Methods */
    func checkFieldsComplete() {
        // Check if textfields are empty
        if self.usernameTextField.text.isEmpty || self.emailTextField.text.isEmpty || self.passwordTextField.text.isEmpty || self.confirmPasswordTextField.text.isEmpty || self.profileImageData == nil {
            // Show Alert
            var incompleteAlert = SCLAlertView()
            incompleteAlert.showError(self, title: "Could Not Log In", subTitle: "Please fill out all textfields and add a profile picture", closeButtonTitle: "Ok", duration: 0)
            
            
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
            var passwordsAlert = SCLAlertView()
            passwordsAlert.showError(self, title: "Could Not Register", subTitle: "Your passwords do not match", closeButtonTitle: "Ok", duration: 0)

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
                var profileImageFile:PFFile = PFFile(data: self.profileImageData)
                self.user.setObject(profileImageFile, forKey: "profileImage")
                self.user.saveInBackgroundWithBlock({ (succeeded: Bool!, error: NSError!) -> Void in
                    if error == nil {
                        println("saved profile pic")
                    }
                })
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
            user.isIosTA = false
            user.isIosStudent = false
            user.isWebStudent = true
            user.isWebTA = false
        } 
    }


    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        if self.profileImageData == nil {
           pictureImageView.alpha = 0.6
        }
    }
    /* UITextFieldDelegate method */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField{
        case self.usernameTextField:
            self.emailTextField.becomeFirstResponder()
        case self.emailTextField:
            self.passwordTextField.becomeFirstResponder()
        case self.passwordTextField:
            self.confirmPasswordTextField.becomeFirstResponder()
        default:()
            
        }
        
        return true
    }
    
}
