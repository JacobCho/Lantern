//
//  AppDelegate.swift
//  Lantern
//
//  Created by Jacob Cho on 2014-11-17.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import UIKit
import Parse
import CoreLocation



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?
    let locationManager:CLLocationManager = CLLocationManager()
    let locationManagerDelegate = LocationManagerDelegate()



    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Set up Parse
        Parse.setApplicationId("Q230SayuCx1mr0l4oSjoWshPvEv6s53fStpXGZLd", clientKey: "U9eCPygvOE13BFW83GlpINGmzUM4HQ2DmHeIaIPl")
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        // Register for Push Notifications
        var types: UIUserNotificationType = UIUserNotificationType.Badge | UIUserNotificationType.Alert | UIUserNotificationType.Sound
        var settings: UIUserNotificationSettings = UIUserNotificationSettings( forTypes: types, categories: nil )
        
        application.registerUserNotificationSettings( settings )
        application.registerForRemoteNotifications()
    
        // Clear Notification Badge Number on App entry
        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
        
        // Register Parse subclasses
        User.registerSubclass()
        Messages.registerSubclass()
        
        // Edit Nav Bar
        let navigationController:UINavigationController = self.window?.rootViewController as UINavigationController
        navigationController.navigationBar.barTintColor = UIColor(red: 12.0/255.0, green: 45.0/255.0, blue: 61.0/255.0, alpha: 1)
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController.navigationBar.translucent = false
        
    
        application.setStatusBarStyle(.LightContent, animated: true)
        
        
        locationManager.delegate = locationManagerDelegate
        locationManager.requestAlwaysAuthorization()

        return true
    }
    
    func application( application: UIApplication!, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData! ) {
        
        var currentInstallation : PFInstallation = PFInstallation.currentInstallation()
        currentInstallation.setDeviceTokenFromData(deviceToken)
        currentInstallation.channels = ["global", User.currentUser().username]
        currentInstallation.saveInBackgroundWithTarget(nil, selector: nil)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        
        let navigationController:UINavigationController = self.window?.rootViewController as UINavigationController

        if let message = userInfo["aps"]?["alert"] as String? {
            var topViewController : UIViewController = navigationController.topViewController
            
             var pushAlert = SCLAlertView()
             pushAlert.showCustom(topViewController, image: UIImage(named: "lighthouseOn"), color: UIColor(red: 47/255, green: 177/255, blue: 118/255, alpha: 1), title: "New Message", subTitle: message, closeButtonTitle: "Ok", duration: 0)

        }

    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        println("fired")
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

