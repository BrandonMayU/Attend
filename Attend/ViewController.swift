//
//  ViewController.swift
//  Attend
//
//  Created by Brandon Mayhew on 2015-11-18.
//  Copyright © 2015 MayU Studios. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var errorTxt: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    //Buttons
    @IBAction func loginButton(sender: AnyObject) {
        print("Login Button Called")
    }
    
    @IBAction func signupButton(sender: AnyObject) {
        print("SignUp Button Called")
    }
    
}

