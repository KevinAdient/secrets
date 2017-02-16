//
//  UserDeviceDetails.swift
//  SAP-container
//
//  Created by Peter Michael Gits on 2/10/17.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

// Singleton Class
class UserDeviceDetails: NSObject {
    var strSample:String
    var uidid:String//unique identifier for Vendor
    var authenticatedPhoneNumber:String?
    var userID:String?//received from Twitter Digits
    var emailID:String?
    var access_token:String?
    var access_tokenDateExpires:NSDate?//this is the NSDate of the time it expires
    var refresh_token:String?
    var upi:String?//this is the actual employee badge number
    var hashedUserID:String?
    var deviceLocation:CLLocation?//provisioned inside of MainViewController
    var theAltitude:NSNumber?
    var firstName:String?
    var lastName:String?
    var role:String?
    var countryName:String?
    var phoneNumberOnFile:String?
    var iFingerprintCounter:NSNumber?
    var iDigitsCounter:NSNumber?
    var offLineMode:NSNumber?

    static let sharedUserAndDeviceManager:UserDeviceDetails = {
        let instance = UserDeviceDetails ()
        return instance
    } ()

// MARK: Init
    override init() {
        print("My Class Initialized")
        // initialized with variable or property
        uidid = (UIDevice.current.identifierForVendor?.uuidString)!
        strSample = "My User"
    }
}

