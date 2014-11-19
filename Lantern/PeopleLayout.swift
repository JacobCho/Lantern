//
//  PeopleLayout.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/18/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class PeopleLayout: UICollectionViewFlowLayout {
    
    
    override func prepareLayout() {
        super.prepareLayout()
        itemSize = CGSizeMake(125, 170)
        minimumLineSpacing = 15
        minimumInteritemSpacing = 15
        sectionInset = UIEdgeInsetsMake(30, 30, 30, 30)
    }
   
}
