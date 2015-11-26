//
//  signUpViewController.swift
//  Attend
//
//  Created by Brandon Mayhew on 2015-11-19.
//  Copyright © 2015 MayU Studios. All rights reserved.
//

import UIKit
import SwiftyJSON

class signUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Elements
    @IBOutlet weak var firstnameTxt: UITextField!
    @IBOutlet weak var lastnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    //Buttons
    @IBAction func signupButton(sender: AnyObject) {
        signUpRequest() //This send the user info to there server
    }
    
    
    //function
    
    func signUpRequest(){
        
        let  firstName : String = firstnameTxt.text!
        let lastName : String = lastnameTxt.text!
        let email : String = emailTxt.text!
        let password : String = passwordTxt.text!
        
        let url : String = "http://www.thegoodsite.org/attend/api.php?newuser_email=\(email)&newuser_name_first=\(firstName)&newuser_name_last=\(lastName)&newuser_pass=\(password)"
        let nsurly = NSURL(string: url)
        let jsonData = NSData(contentsOfURL: nsurly!) as NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        let sendRequest = readableJSON
        
        NSLog("JSON FILE \(sendRequest)")
        
        //Find the Sesh ID in JSON and store as a variable-----
        
        let userSessionID = readableJSON["newsessid"]
        NSLog("SESHID \(userSessionID)")
        
        let uid = readableJSON["newuser"]
        NSLog("\(uid)")
        
        let errorText = readableJSON["errorText"]
        NSLog("Error Text: \(errorText)")
        
        let successText = readableJSON["success"]
        NSLog("Succes : \(successText)")
        
        if(errorText == nil){
            errorLabel.hidden = true
            if(successText == true){
                //Allow the seuge to attend work
                performSegueWithIdentifier("signUptoAttend", sender: nil)
            }else{
                print("Success : Fail")
            }
        }else{
            errorLabel.hidden = false
            errorLabel.text = "\(errorText)"
        }
        
        //-----------------------------------------------------
        
        /*
        enum defaultsKeys {
        static let keyOne = "firstStringKey"
        static let keyTwo = "secondStringKey"
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue("Some String Value", forKey: defaultsKeys.keyOne)
        defaults.setValue("Another String Value", forKey: defaultsKeys.keyTwo)
        
        defaults.synchronize()
        
        
        let defualtsCheck = NSUserDefaults.standardUserDefaults()
        
        if let stringOne = defaults.stringForKey(defaultsKeys.keyOne) {
        print(stringOne) // Some String Value
        }
        
        if let stringTwo = defaults.stringForKey(defaultsKeys.keyTwo) {
        print(stringTwo) // Another String Value
        }
        */

        
        //PARSE JSON FILE FOR SESH ID--------
        
        enum defaultsKeys{
            static let keyOne = "SeshID:"
            static let keyTwo = "UID:"
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setValue("\(userSessionID)", forKey: defaultsKeys.keyOne)
        defaults.setValue("\(uid)", forKey: defaultsKeys.keyTwo)
        
        defaults.synchronize() //SESH ID and UID has been sent
        
        //View the local datastore
        let defualtsCheck = NSUserDefaults.standardUserDefaults()
        
        if let stringOne = defaults.stringForKey(defaultsKeys.keyOne) {
            print("LOCAL DATA STORE: SESSION ID: \(stringOne)") // Some String Value
        }
        
        if let stringTwo = defaults.stringArrayForKey(defaultsKeys.keyTwo){
            print("LOCAL DATA STORE : UID: \(stringTwo)")
        }
        //-----------------------------------
        
        
        
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        firstnameTxt.resignFirstResponder()
        lastnameTxt.resignFirstResponder()
        emailTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
    }
    
    
    

}
