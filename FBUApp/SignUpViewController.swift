//
//  SignUpViewController.swift
//  FBUApp
//
//  Created by Kelly Lampotang on 7/5/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSignUp(sender: AnyObject) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        
        
        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error)
            } else {
                print("User Registered successfully")
                
                let currUser = PFUser.currentUser()
                
                currUser!.setObject(self.firstNameTextField.text!, forKey: "firstName")
                currUser!.setObject(self.lastNameTextField.text!, forKey: "lastName")
                currUser!.setObject(self.ageTextField.text!, forKey: "age")
                let empty: [PFObject] = []
                currUser!.setObject(empty, forKey: "saved")
                let firstNameCurrUser = currUser?["firstName"] as! String
                print(firstNameCurrUser)
                let saved = currUser?["saved"] as! [PFObject]
                print(saved.count)
                // manually segue to logged in view
                
            }
        }
    }


}
