//
//  MessageTableViewCell.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-19.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import Parse

class MessageTableViewCell: PFTableViewCell {

//    @IBOutlet weak var messageLabel: UILabel!
//    @IBOutlet weak var senderLabel: UILabel!
    
    @IBOutlet var messageTextLabel: UILabel!
    @IBOutlet var chatBubbleTail: UIImageView!
    @IBOutlet var profileImageView: PFImageView!
    
    
     override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        self.clipsToBounds = false
        
    }
    //TODO: find callback
}
