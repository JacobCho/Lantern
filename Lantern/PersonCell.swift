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

class PersonCell: UICollectionViewCell {
    
    var person:User!
    
    @IBOutlet var imageView: PFImageView!
    @IBOutlet var nameLabel: UILabel!
    
    /* Adds background pulse to imageviews */
    func addPulses(quantity:Float) {
        // Make the background circle
        let pulseView = UIView()
        pulseView.frame = self.imageView.frame
        pulseView.backgroundColor = UIColor(red: 26.0/255.0, green: 188.0/255.0, blue: 156.0/255.0, alpha: 1)
        pulseView.layer.cornerRadius = self.imageView.frame.width/2
        
        self.contentView.addSubview(pulseView)
        self.contentView.sendSubviewToBack(pulseView)
        // Add the pulse animation
        let scaleAnimation = CABasicAnimation()
        scaleAnimation.keyPath = "transform.scale"
        scaleAnimation.duration = 0.5
        scaleAnimation.repeatCount = quantity
        scaleAnimation.autoreverses = true
        scaleAnimation.fromValue = 1.1
        scaleAnimation.toValue = 0.8
        pulseView.layer.addAnimation(scaleAnimation, forKey: "scale")
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
}
