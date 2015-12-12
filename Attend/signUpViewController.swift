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
    
    
    //functions
    
    func signUpRequest(){
        let email : String = emailTxt.text!
        let password : String = passwordTxt.text!
        let firstName : String = firstnameTxt.text!
        let lastName : String = lastnameTxt.text!
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
        saveData()
    }
    
    func saveData(){
        
        enum defaultsKeys{
            static let sessionID = "SeshID:"
            static let UID = "UID:"
            static let firstName = "FirstName:"
            static let lastName = "LastName"
        }
        
        let email : String = emailTxt.text!
        let password : String = passwordTxt.text!
        let firstName : String = firstnameTxt.text!
        let lastName : String = lastnameTxt.text!
        
        let url : String = "http://www.thegoodsite.org/attend/api.php?newuser_email=\(email)&newuser_name_first=\(firstName)&newuser_name_last=\(lastName)&newuser_pass=\(password)"
        let nsurly = NSURL(string: url)
        let jsonData = NSData(contentsOfURL: nsurly!) as NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        let userSessionID = readableJSON["newsessid"]
        NSLog("SESHID \(userSessionID)")
        let uid = readableJSON["newuser"]
        NSLog("\(uid)")
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("\(userSessionID)", forKey: defaultsKeys.sessionID)
        defaults.setValue("\(uid)", forKey: defaultsKeys.UID)
        defaults.synchronize() //SESH ID and UID has been sent
    }
    
    class func loadSessionID() -> String{
        let sessionID = "SeshID:"
        let defaults = NSUserDefaults.standardUserDefaults()
        if let stringOne = defaults.stringForKey(sessionID) {
            print("LOCAL DATA STORE: SESSION ID: \(stringOne)") // Some String Value
            return stringOne
        }
        return "failed"
    }
    
    class func loadUID() -> Int{
        let UID = "UID:"
        let defaults = NSUserDefaults.standardUserDefaults()
        if let stringTwo = defaults.stringForKey(UID){
            print("LOCAL DATA STORE : UID: \(stringTwo)")
            let num:Int? = Int(stringTwo)
            return num!
        }
        return 0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        firstnameTxt.resignFirstResponder()
        lastnameTxt.resignFirstResponder()
        emailTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
    }
    
    
    
    
}
