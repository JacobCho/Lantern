//
//  FinderViewController.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/18/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import MapKit

private struct mapIconStartingPosition {
    //all points are relative to a 1500px square map
    static let wmsWC1 = CGPointMake(847, 735)
    static let wmsWC2 = CGPointMake(920, 760)
    static let mnsWC1 = CGPointMake(815, 650)
    static let bikeRm = CGPointMake(820, 475)
    static let kitchen = CGPointMake(830, 387)
    static let exit1 = CGPointMake(402, 510)
    static let exit2 = CGPointMake(1050,805)
    
}

class FinderViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet var indoorMap: IndoorMapView!
    
    let womensBathroomIcon1 = UIImageView(image: UIImage(named: "WomensIcon_1x"))
    let womensBathroomIcon2 = UIImageView(image: UIImage(named: "WomensIcon_1x"))
    let mensBathroomIcon = UIImageView(image: UIImage(named: "MensIcon_1x"))
    let bikeRoomIcon = UIImageView(image: UIImage(named: "BikeRoom_1x"))
    let exitIcon1 = UIImageView(image: UIImage(named: "ExitIcon_1x"))
    let exitIcon2 = UIImageView(image: UIImage(named: "ExitIcon_1x"))
    let kitchenIcon = UIImageView(image: UIImage(named: "KitchenIcon_1x"))

    var userToBeFound:User = User()
    var person:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title=userToBeFound.username

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.configureMap()

    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.indoorMap.viewWithTag(1)
        
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        var scale:CGFloat = self.indoorMap.viewWithTag(1)!.frame.size.width/1500.0
    self.layoutMapIcons(scale)
        
    }
    
    func configureMap(){
        
        self.layoutMapIcons(1.0)

        self.indoorMap.addSubview(womensBathroomIcon1)
        self.indoorMap.addSubview(womensBathroomIcon2)
        self.indoorMap.addSubview(mensBathroomIcon)
        self.indoorMap.addSubview(bikeRoomIcon)
        self.indoorMap.addSubview(exitIcon1)
        self.indoorMap.addSubview(exitIcon2)
        self.indoorMap.addSubview(kitchenIcon)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
//        println("I see scrolling!")
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var chatContainer: ChatContainerViewController = segue.destinationViewController as ChatContainerViewController
        chatContainer.messageRecipient = userToBeFound
    }
    
    func layoutMapIcons(scale: CGFloat){
        womensBathroomIcon1.frame = CGRect(x: mapIconStartingPosition.wmsWC1.x * scale, y: mapIconStartingPosition.wmsWC1.y * scale, width: 60, height: 60)
        womensBathroomIcon2.frame = CGRect(x: mapIconStartingPosition.wmsWC2.x * scale, y: mapIconStartingPosition.wmsWC2.y * scale, width: 60, height: 60)
        mensBathroomIcon.frame = CGRect(x: mapIconStartingPosition.mnsWC1.x * scale, y: mapIconStartingPosition.mnsWC1.y * scale, width: 60, height: 60)
        bikeRoomIcon.frame = CGRect(x: mapIconStartingPosition.bikeRm.x * scale, y: mapIconStartingPosition.bikeRm.y * scale, width: 60, height: 60)
        exitIcon1.frame = CGRect(x: mapIconStartingPosition.exit1.x * scale, y: mapIconStartingPosition.exit1.y * scale, width: 60, height: 60)
        exitIcon2.frame = CGRect(x: mapIconStartingPosition.exit2.x * scale, y: mapIconStartingPosition.exit2.y * scale, width: 60, height: 60)
        kitchenIcon.frame = CGRect(x: mapIconStartingPosition.kitchen.x * scale, y: mapIconStartingPosition.kitchen.y * scale, width: 60, height: 60)

    }
    

}
