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
    static let wmsWC1 = CGPointMake(800, 770)
    static let wmsWC2 = CGPointMake(845, 770)
    static let mnsWC1 = CGPointMake(777, 720)
    static let bikeRm = CGPointMake(750, 630)
    static let kitchenIcon = CGPointMake(750, 570)
    static let exit1 = CGPointMake(540, 720)
    static let exit2 = CGPointMake(930,782)
    static let LAnw = CGPointMake(503,462)
    static let LAsw = CGPointMake(503, 888)
    static let LAsouth = CGPointMake(701,902)
    static let LAnBoardroom = CGPointMake(604,462)
    static let kitchen = CGPointMake(699,462)
    static let LHoffices = CGPointMake(819,462)
    static let LAMain = CGPointMake(604,558)
    static let LHMain = CGPointMake(818,745)
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

    let lAnw = UIImageView(image: UIImage(named: "LAnorthwest"))
    let lAnorthBoardroom = UIImageView(image: UIImage(named: "LAnorthBoardroom"))
    let lAsouthwest = UIImageView(image: UIImage(named: "LAsouthwest"))
    let lAsouth = UIImageView(image: UIImage(named: "LAsouth"))
    let lAworkarea = UIImageView(image: UIImage(named: "LAworkarea"))
    let kitchen = UIImageView(image: UIImage(named: "Kitchen"))
    let lHoffices = UIImageView(image: UIImage(named: "LHOffices"))
    let lHworkarea = UIImageView(image: UIImage(named: "LHworkarea"))
    
    

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
    self.layoutMapOverlays(scale)
        
    }
    
    func configureMap(){
        
        self.layoutMapOverlays(1.0)

        self.indoorMap.addSubview(lAnw)
        self.indoorMap.addSubview(lAnorthBoardroom)
        self.indoorMap.addSubview(lAsouthwest)
        self.indoorMap.addSubview(lAsouth)
        self.indoorMap.addSubview(lAworkarea)
        self.indoorMap.addSubview(lHoffices)
        self.indoorMap.addSubview(lHworkarea)
        self.indoorMap.addSubview(kitchen)
        
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
    
    func layoutMapOverlays(scale: CGFloat){
        
        womensBathroomIcon1.frame.size = CGSize(width: 45, height: 45)
        womensBathroomIcon1.center = CGPoint(x:mapIconStartingPosition.wmsWC1.x * scale, y:mapIconStartingPosition.wmsWC1.y * scale)
        
        womensBathroomIcon2.frame.size = CGSize(width: 45, height: 45)
        womensBathroomIcon2.center = CGPoint(x: mapIconStartingPosition.wmsWC2.x * scale, y: mapIconStartingPosition.wmsWC2.y * scale)
        
        mensBathroomIcon.frame.size = CGSize(width: 45, height: 45)
        mensBathroomIcon.center = CGPoint(x: mapIconStartingPosition.mnsWC1.x * scale, y: mapIconStartingPosition.mnsWC1.y * scale)
        
        bikeRoomIcon.frame.size = CGSize(width: 45, height: 45)
        bikeRoomIcon.center = CGPoint(x: mapIconStartingPosition.bikeRm.x * scale, y: mapIconStartingPosition.bikeRm.y * scale)
        
        exitIcon1.frame.size = CGSize(width: 45, height: 45)
        exitIcon1.center = CGPoint(x: mapIconStartingPosition.exit1.x * scale, y: mapIconStartingPosition.exit1.y * scale)
            
        exitIcon2.frame.size = CGSize(width: 45, height: 45)
        exitIcon2.center = CGPoint(x: mapIconStartingPosition.exit2.x * scale, y: mapIconStartingPosition.exit2.y * scale)
        
        kitchenIcon.frame.size = CGSize(width: 45, height: 45)
        kitchenIcon.center = CGPoint(x: mapIconStartingPosition.kitchenIcon.x * scale, y: mapIconStartingPosition.kitchenIcon.y * scale)
        
        lAnw.frame = CGRect(x: mapIconStartingPosition.LAnw.x * scale, y: mapIconStartingPosition.LAnw.y * scale, width: 102 * scale, height: 450 * scale )
        lAnw.alpha = 0.2
        lAnw.hidden = true
        
        lAnorthBoardroom.frame = CGRect(x: mapIconStartingPosition.LAnBoardroom.x * scale, y: mapIconStartingPosition.LAnBoardroom.y * scale, width: 93 * scale, height: 95 * scale)
        lAnorthBoardroom.alpha = 0.2
        if userToBeFound.room == RoomNames.LANorthWest {
            lAnorthBoardroom.hidden = false
        } else {
            lAnorthBoardroom.hidden = true
        }
        
        
        lAsouthwest.frame = CGRect(x: mapIconStartingPosition.LAsw.x * scale, y: mapIconStartingPosition.LAsw.y * scale, width: 199 * scale, height: 211 * scale)
        lAsouthwest.alpha = 0.2
        if userToBeFound.room == RoomNames.LASouthWest{
            lAsouthwest.hidden = false
        } else {
            lAsouthwest.hidden = true
        }

        lAsouth.frame = CGRect(x: mapIconStartingPosition.LAsouth.x * scale, y: mapIconStartingPosition.LAsouth.y * scale, width: 117 * scale, height: 197 * scale)
        lAsouth.alpha  = 0.2
        if userToBeFound.room == RoomNames.LASouth{
            lAsouth.hidden = false
        } else {
            lAsouth.hidden = true
        }
        
        lAsouth.hidden = true

        lAworkarea.frame = CGRect(x: mapIconStartingPosition.LAMain.x * scale, y: mapIconStartingPosition.LAMain.y * scale, width: 178 * scale, height: 354 * scale)
        lAworkarea.alpha  = 0.2
        if userToBeFound.room == RoomNames.LAMain{
            lAworkarea.hidden = false
        } else {
            lAworkarea.hidden = true
        }

        kitchen.frame = CGRect(x: mapIconStartingPosition.kitchen.x * scale, y: mapIconStartingPosition.kitchen.y * scale, width: 120 * scale, height: 147 * scale)
        kitchen.alpha  = 0.2
        kitchen.hidden = true

        lHoffices.frame = CGRect(x: mapIconStartingPosition.LHoffices.x * scale, y: mapIconStartingPosition.LHoffices.y * scale, width: 134 * scale, height: 293 * scale)
        lHoffices.alpha  = 0.2
        if userToBeFound.room == RoomNames.LHOffice{
            lHoffices.hidden = false
        } else {
            lHoffices.hidden = true
        }
        
        lHworkarea.frame = CGRect(x: mapIconStartingPosition.LHMain.x * scale, y: mapIconStartingPosition.LHMain.y * scale, width: 135 * scale, height: 354 * scale)
        lHworkarea.alpha  = 0.2
        if userToBeFound.room == RoomNames.LHMain{
            lHworkarea.hidden = false
        } else {
            lHworkarea.hidden = true
        }
        
        kitchen.frame = CGRect(x: mapIconStartingPosition.kitchen.x * scale, y: mapIconStartingPosition.kitchen.y * scale, width: 120 * scale, height: 147 * scale)
        kitchen.alpha = 0.2
        if userToBeFound.room == RoomNames.Kitchen{
            kitchen.hidden = false
        } else {
            kitchen.hidden = true
        }
        
    }

    

}
