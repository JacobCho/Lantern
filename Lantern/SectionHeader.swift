//
//  SectionHeader.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/23/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit


class SectionHeader: UICollectionReusableView {
    
    let contentView:UIView = UIView()
    var titleLabel:UILabel! = UILabel(frame: CGRect(x: 50, y: 25, width: 200, height: 50))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = CGRect(x: 10, y: 10, width: 200, height: 50)
        contentView.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        contentView.layer.cornerRadius = 7
        contentView.clipsToBounds = true
        titleLabel.frame = CGRect(x: 10, y: 10, width: contentView.frame.size.width-20, height: contentView.frame.size.height-20)
        titleLabel.textColor = UIColor.whiteColor()
        contentView.addSubview(titleLabel)
        self.addSubview(contentView)

    }
    
//    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes! {
//        self.addSubview(titleLabel)
//        titleLabel.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
//        titleLabel.frame = CGRect(x: 50, y: 25, width: 200, height: 50)
//        
//        return layoutAttributes
//    }
    
    override func prepareForReuse() {
        self.addSubview(titleLabel)
        titleLabel.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        titleLabel.frame = CGRect(x: 50, y: 25, width: 200, height: 50)
    }
    
        

}
