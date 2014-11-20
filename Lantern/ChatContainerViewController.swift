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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatTextField.delegate = self
    }
    
    /* UITextFieldDelegate Method */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
