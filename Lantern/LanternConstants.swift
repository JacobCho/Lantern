//
//  LanternConstants.swift
//  Lantern
//
//  Created by Tucker Sherman on 11/23/14.
//  Copyright (c) 2014 J & T. All rights reserved.
//

import Foundation

struct globalConst {
    
    static let updateSpeed:NSTimeInterval = NSTimeInterval(20)
    
}

struct RoomNames {
    
    static let LANorthWest = "Launch Academy Back Offices"
    static let LASouthWest = "Launch Academy Front Offices"
    static let LASouth = "Launch Academy Board Room"
    static let LAMain = "Launch Academy Main Work Area"
    static let Kitchen = "Kitchen"
    static let LHOffice = "Lighthouse Labs Office"
    static let LHMain = "Lighthouse Labs Main Work Area"
    static let None = "somewhere out of range"
    
}

enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS =  UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.currentDevice().userInterfaceIdiom == .Phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}