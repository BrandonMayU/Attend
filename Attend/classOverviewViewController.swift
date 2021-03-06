//
//  classOverviewViewController.swift
//  Attend
//
//  Created by Brandon Mayhew on 2015-11-19.
//  Copyright © 2015 MayU Studios. All rights reserved.
//

import UIKit
import SwiftyJSON

class classOverviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        roundIcon()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //Elements
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var schoolImage: UIImageView!
    
    //Buttons
    @IBAction func attendButton(sender: AnyObject) {    //This button will take you too ibeacon sensor
        
    }
    
    //Functions
    
    func roundIcon(){
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2 //Rounding image
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderColor = UIColor.whiteColor().CGColor //Boarder Color
        profilePicture.layer.borderWidth = 3 //Boarder Size
        
    }

}
