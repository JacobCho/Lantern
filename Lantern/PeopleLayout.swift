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
        minimumLineSpacing = 20
        minimumInteritemSpacing = 20
        sectionInset = UIEdgeInsetsMake(0, 50, 20, 50)
        headerReferenceSize = CGSize(width: collectionView!.frame.size.width, height: 100)
        
        

    }


}
