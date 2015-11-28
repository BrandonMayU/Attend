//
//  iBeaconScannerViewController.swift
//  Attend
//
//  Created by Brandon Mayhew on 2015-11-20.
//  Copyright © 2015 MayU Studios. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class iBeaconScannerViewController: UIViewController , CLLocationManagerDelegate {
    var completedCheckIn = false
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "2173E519-9155-4862-AB64-7953AB146156")!, identifier: "GemTot")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser()
        
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
    }

    
    //Elements
    @IBOutlet weak var animatedCheckIn: UIImageView! //Image for Check-In *Animated
    @IBOutlet weak var studentName: UILabel! //We can get the current user and display there name in the UI
    @IBOutlet weak var statusLabel: UILabel! //This tells the student there distant to the beacon
    @IBOutlet weak var getCloser: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    
    
    //Functions
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            updateDistance(closestBeacon.proximity)
            //var value = updateDistance(closestBeacon.proximity)
        }
        else {
            self.view.backgroundColor = UIColor.grayColor()
            statusLabel.text = "Can't Find iBeacon"
        }
    }
    func updateDistance(distance: CLProximity)
    {
        UIView.animateWithDuration(0.2)
            {
                switch distance
                {
                case .Unknown:
                    //self.view.backgroundColor = UIColor.grayColor()
                    self.view.backgroundColor = UIColor.blackColor()
                    self.statusLabel.text = "Can't Find iBeacon"
                case .Far:
                    //self.view.backgroundColor = UIColor.blueColor()
                    self.hideCheckin()
                    self.view.backgroundColor = UIColor(red: 201/255, green: 43/255, blue: 43/255, alpha: 1)
                    self.statusLabel.text = "Get Closer to the Beacon!"
                    self.statusLabel.textColor = UIColor.whiteColor()
                case .Near:
                    //self.view.backgroundColor = UIColor.orangeColor()
                    self.view.backgroundColor = UIColor.orangeColor() //Orange
                    self.statusLabel.text = "iBeacon is Near"
                    self.statusLabel.textColor = UIColor.whiteColor()
                    self.showName()
                    self.showCheckin()
                case .Immediate:
                    self.view.backgroundColor = UIColor.greenColor()
                    self.statusLabel.text = "iBeacon is Close"
                    self.statusLabel.textColor = UIColor.whiteColor()
                    self.showName()
                    self.showCheckin()
                    print("Close")
                }
        }
    }
    
    func showName(){
        //Right Code that can read JSON to get the current usersname
    }
    
    func hideCheckin(){
        //This code hides part of the UI if you are to far out of range
        welcomeLabel.hidden = true
        studentName.hidden = true
        animatedCheckIn.hidden = true
        getCloser.hidden = false
        statusLabel.hidden = false
    }
    
    func showCheckin(){
        //This code makes all parts of the UI visibile if you are within range of the iBeacon
        welcomeLabel.hidden = false
        studentName.hidden = false
        animatedCheckIn.hidden = false
        getCloser.hidden = true
        statusLabel.hidden = false
    }
    
    func currentUser(){
        
        
        
        //1. Find session id (Get this off the local datastore)
        let seshID = signUpViewController.loadSessionID()
        let UID = String(signUpViewController.loadUID())
        print("Session ID: \(seshID) UID: \(UID)")
        
        //2. Use the session id to send a get request
        let url : String = "http://www.thegoodsite.org/attend/api.php?current_uid=\(UID)&current_sessid=\(seshID)" //Login get request link
        let urlNS = NSURL(string: url) //conver url to a NSURL
        let jsonData = NSData(contentsOfURL: urlNS!) as NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        print("\(readableJSON)")
        //3. Store current user info as var from the JSON file
        let currentUserName = readableJSON["current_user"]["name_first"]
        print("Current User Name: \(currentUserName)")
        
        
        
    }
    
    


}
