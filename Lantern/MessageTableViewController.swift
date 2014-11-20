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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(className User: String!) {
        super.init(className: User)
        
        self.parseClassName = User
        self.textKey = "YOUR_PARSE_COLUMN_YOU_WANT_TO_SHOW"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }


}
