//
//  ViewController.swift (Main Login Screen)
//  Attend
//
//  Created by Brandon Mayhew on 2015-11-18.
//  Copyright © 2015 MayU Studios. All rights reserved.
//


import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Elements
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    //Buttons
    @IBAction func loginButton(sender: AnyObject) {
        print("Login Button Called")
        let email = emailTxt.text!
        let password = passwordTxt.text!
        
        if(email == "" || password == ""){
            errorLabel.text = "Email & Password Empty"
            errorLabel.hidden = false
            print("Email and Password are missing Text")
        }else{
            errorLabel.hidden = true
            sendLoginRequest()
        }
    }
    
    @IBAction func signupButton(sender: AnyObject) {
        print("SignUp Button Called")
    }
    
    
    //functions=========================================================================
    
    //Current User NAME AND LASTNAME--------------------
    
    func currentUserFirstName() -> String {
        
        
        
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
        let currentUserName = readableJSON["current_user"][0]["name_first"]
        print("Current User Name: \(currentUserName)")
        let currentUserLastName = readableJSON["current_user"][0]["name_last"]
        print("Current User LastName: \(currentUserLastName)")
        
        return String(currentUserName)
        
        
        
    }
    
    func currentUserLastName() ->String {
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
        let currentUserName = readableJSON["current_user"][0]["name_first"]
        print("Current User Name: \(currentUserName)")
        let currentUserLastName = readableJSON["current_user"][0]["name_last"]
        print("Current User LastName: \(currentUserLastName)")
        
        return String(currentUserLastName)
    }
    --------------------------------------------
    
    
    func forceLocalDataStore(){
        let FirstName : String = currentUserFirstName()
        let LastName : String = currentUserLastName()
        
        enum defaultsKeys{
            static let sessionID = "SeshID:"
            static let UID = "UID:"
            static let firstName = "FirstName:"
            static let lastName = "LastName"
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("\(FirstName)", forKey: defaultsKeys.firstName)
        defaults.setValue("\(LastName)", forKey: defaultsKeys.lastName)
        defaults.synchronize() //SESH ID and UID has been sent
        
        
    }
    
    
    func sendLoginRequest(){
        
        let email : String = emailTxt.text! //Store email as String
        let password : String = passwordTxt.text!  //Store passwd as String
        /*
        
        let url : String = "http://www.thegoodsite.org/attend/api.php?newuser_email=\(email)&newuser_name_first=\(firstName)&newuser_name_last=\(lastName)&newuser_pass=\(password)"
        let nsurly = NSURL(string: url)
        let jsonData = NSData(contentsOfURL: nsurly!) as NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        let sendRequest = readableJSON
        
        */
        
        let url : String = "http://thegoodsite.org/attend/api.php?signin_email=\(email)&signin_pass=\(password)" //Login get request link
        let urlNS = NSURL(string: url) //conver url to a NSURL
        let jsonData = NSData(contentsOfURL: urlNS!) as NSData!
        let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
        
        
        let getLoginPermission = readableJSON //This lets us read the JSON
        print("\(getLoginPermission)")        //Print to the console to check
        var succesValue = readableJSON["success"]
        print("Success : \(succesValue)")
        let errorKind = readableJSON["errorText"]
        print("ErrorKind: \(errorKind)")
        //This breaks down the login with if statment
        if succesValue == true{
            if (errorKind == nil){
                
                print("Have passed error system")
                errorLabel.hidden = true
                
                    if(succesValue == true){
                        print("SUCCESSFULLY Verifed user!")
                        //User has succesfull passed the check and may contiue
                        performSegueWithIdentifier("loginSuccess", sender: nil)
                    
                    }else{
                        print("Failed to verify user")
                        errorLabel.text = "\(errorKind)"
                        errorLabel.hidden = false
                    }
            }
        
        
        
        
            enum defaultsKeys{
                static let sessionID = "SeshID:"
                static let UID = "UID:"
            }
            
        //saves the data
        //needs access to the first name & last name
        let userSessionID = readableJSON["newsessid"]
        NSLog("SESHID \(userSessionID)")
        let uid = readableJSON["uid"]
        NSLog("USER ID SHOULD BE HERE:\(uid)")
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue("\(userSessionID)", forKey: defaultsKeys.sessionID)
        defaults.setValue("\(uid)", forKey: defaultsKeys.UID)
        defaults.synchronize() //SESH ID and UID has been sent
        
        forceLocalDataStore()
        }
        
        func succesInfo()->Bool{  //This line sends a json request to see the status of the success value at login!
            
            var email = emailTxt.text
            var password = passwordTxt.text
            
            let url : String = "http://thegoodsite.org/attend/api.php?signin_email=\(email)&signin_pass=\(password)" //Login get request link
            let urlNS = NSURL(string: url) //conver url to a NSURL
            let jsonData = NSData(contentsOfURL: urlNS!) as NSData!
            let readableJSON = JSON(data: jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil)
            
            
            let getLoginPermission = readableJSON //This lets us read the JSON
            print("\(getLoginPermission)")        //Print to the console to check
            var succesValue = readableJSON["success"]
            
        }
    
    //===============================================================================
        
        
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        emailTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
    }
    

  

    
}
}