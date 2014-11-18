//
//  FinderViewController.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/18/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class FinderViewController: UIViewController {
    
    
    var userToBeFound:User = User()
    
    

    @IBOutlet var tempLabel: UILabel!

    
    var person:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempLabel.text = userToBeFound.username
        
        
        
        

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
