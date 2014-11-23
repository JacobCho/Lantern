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
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addPulse()
    }
    
    /* Adds background pulse to imageviews */
    func addPulse() {
        // Make the background circle
        let pulseView = UIView()
        pulseView.frame = CGRectMake(0, 0, 90, 90)
        pulseView.center = self.imageView.center
        pulseView.center.x -= 27
        pulseView.center.y -= 15
        pulseView.backgroundColor = UIColor(red: 49/255, green: 168/255, blue: 247/255, alpha: 0.8)
        pulseView.layer.cornerRadius = 45
        
        self.addSubview(pulseView)
        
        self.sendSubviewToBack(pulseView)
        // Add the pulse animation
        let scaleAnimation = CABasicAnimation()
        scaleAnimation.keyPath = "transform.scale"
        scaleAnimation.duration = 0.5
        scaleAnimation.repeatCount = 500
        scaleAnimation.autoreverses = true
        scaleAnimation.fromValue = 1.1
        scaleAnimation.toValue = 0.8
        
        pulseView.layer.addAnimation(scaleAnimation, forKey: "scale")
        
    }
    
}
