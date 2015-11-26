//
//  ViewController.swift
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
            print("Email and Password are missing Text")
        }else{
            sendLoginRequest()
        }
    }
    
    @IBAction func signupButton(sender: AnyObject) {
        print("SignUp Button Called")
    }
    
    
    //functions
    
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
        let succesValue = readableJSON["success"] 
        print("Success : \(succesValue)")
        let errorKind = readableJSON["errorText"]
        print("ErrorKind: \(errorKind)")
        
        
        //This breaks down the login with if statment
        if (errorKind == nil){
        
            print("Have passed error system")
            errorLabel.hidden = true
            if(succesValue == true){
                print("SUCCESSFULLY Verifed user!")
                //User has succesfull passed the check and may contiue
                performSegueWithIdentifier("loginSuccess", sender: nil)
                
            }else{
                print("Failed to verify user")
            }
        }else{
            errorLabel.text = "\(errorKind)"
            errorLabel.hidden = false
        }
        
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        emailTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
    }
}

