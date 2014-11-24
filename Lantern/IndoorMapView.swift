//
//  IndoorMapView.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/23/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class IndoorMapView: UIScrollView, UIScrollViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        println("storyboard called me")
        self.minimumZoomScale = 1
        self.maximumZoomScale = 3
        self.decelerationRate = 0.4
        
    }

    

}
