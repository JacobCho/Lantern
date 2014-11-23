//
//  FinderViewController.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/18/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import MapKit


class FinderViewController: UIViewController {
    
    
    var userToBeFound:User = User()
    
    

    @IBOutlet var mapView: MKMapView!

    var person:User!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title=userToBeFound.username
//        self.configureMap()

        // Do any additional setup after loading the view.
    }
    
    func configureMap(){
        let lighthouseCoordinates = CLLocationCoordinate2D(latitude: 49.2821725, longitude: -123.1080759)
        let mapSize = MKCoordinateRegion(center: lighthouseCoordinates, span: MKCoordinateSpan(latitudeDelta: 0.00001, longitudeDelta: 0.00001))
        self.mapView.region = mapSize
        
//        self.mapView.camera
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        
        // Dispose of any resources that can be recreated.
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var chatContainer: ChatContainerViewController = segue.destinationViewController as ChatContainerViewController
        chatContainer.messageRecipient = userToBeFound
    }
    

}
