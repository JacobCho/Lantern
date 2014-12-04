//
//  PersonCell.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/17/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import Parse
import QuartzCore

struct PulseColor {
    
    static let defaultColor = UIColor(red: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1)
    static let orangeColor = UIColor(red: 241.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1)
    static let blueColor = UIColor(red: 44.0/255.0, green: 196.0/255.0, blue: 242.0/255.0, alpha: 1)
    
}

class PersonCell: UICollectionViewCell {
    
    var person:User!
    
    @IBOutlet var imageView: PFImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var cellBackground: UIImageView!
    
    
    /* Adds background pulse to imageviews */
//    func addPulses(pulses:Float) {
//        // Make the background circle
//        let pulseView = UIView()
//        pulseView.frame = self.imageView.frame
//        pulseView.backgroundColor = pulseColorByRoom()
//        pulseView.layer.cornerRadius = self.imageView.frame.width/2
//        
//        self.contentView.addSubview(pulseView)
//        self.contentView.sendSubviewToBack(pulseView)
//        // Add the pulse animation
//        let scaleAnimation = CABasicAnimation()
//        scaleAnimation.keyPath = "transform.scale"
//        scaleAnimation.duration = 0.5
//        scaleAnimation.repeatCount = pulses
//        scaleAnimation.autoreverses = true
//        scaleAnimation.fromValue = 1
//        scaleAnimation.toValue = 1.1
//        pulseView.layer.addAnimation(scaleAnimation, forKey: "scale")
//        
//    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.cellBackground.layer.cornerRadius = self.cellBackground.frame.width/2
        self.cellBackground.clipsToBounds = true
       
        if let room = self.person.room {
            
            if room == RoomNames.LHMain {
                self.cellBackground.backgroundColor = PulseColor.defaultColor
            } else if room == RoomNames.Kitchen {
                self.cellBackground.backgroundColor = PulseColor.orangeColor
            } else if room == RoomNames.LAMain {
                self.cellBackground.backgroundColor = PulseColor.blueColor
            } else {
                self.cellBackground.backgroundColor = UIColor.grayColor()
            }
            
        }
    }
}