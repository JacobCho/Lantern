//
//  DropdownAlert.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-27.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class DropdownAlert: UIButton {
    


    private func setupView() {
        
        self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 80)
        self.backgroundColor = UIColor(red: 255/255, green: 191/255, blue: 20/255, alpha: 1)
        self.titleLabel!.text = "Test"
        
    }
    
}