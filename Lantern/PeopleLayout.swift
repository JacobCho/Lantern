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
        itemSize = CGSizeMake(125, 140)
        minimumLineSpacing = 15
        minimumInteritemSpacing = 15
        sectionInset = UIEdgeInsetsMake(30, 50, 30, 50)
//        headerReferenceSize = CGSizeMake(self.collectionViewContentSize().width,50)
//        registerClass(SectionHeader.self, forDecorationViewOfKind: "sectionHeader")
        

    }

}
