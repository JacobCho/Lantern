//
//  AvailabilityViewController.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/17/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class AvailabilityViewController: UICollectionViewController {
    
    var peopleInGroup:Array<User> = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        self.collectionView!.dataSource = self
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
//        return peopleInGroup.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("personCell", forIndexPath: indexPath) as PersonCell
        cell.imageView.image = UIImage(named: "person")
        cell.nameLabel.text = "Name"
        
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("registered a selection at \(collectionView.cellForItemAtIndexPath(indexPath))")
        
    }
    


}
