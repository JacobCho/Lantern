//
//  AvailabilityCollectionViewController.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/17/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit

class AvailabilityCollectionViewController: UICollectionViewController, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
//    @IBOutlet var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.backgroundColor = UIColor.whiteColor()

//        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.backgroundColor = UIColor.blackColor()
        navigationController?.navigationBar.tintColor = UIColor.greenColor()
        
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PersonCell", forIndexPath: indexPath) as PersonCellTwo
        cell.backgroundColor = UIColor.whiteColor()
        cell.profileImageView.image = UIImage(named:"person")
        
    
        
        return cell
        

    }
    

}
