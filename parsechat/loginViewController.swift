//
//  ViewController.swift
//  parsechat
//
//  Created by Judy Gatobu on 2/27/18.
//  Copyright © 2018 Judy Gatobu. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func OnTapOnSignUp(_ sender: Any) {
        
        if let email = emailField.text, let pwd = passwordField.text
            , let username = usernameField.text,(email.characters.count > 3 &&
            pwd.characters.count > 0 && username.characters.count > 0 ){
            
            self.registerUser(username: username ,password: pwd
                ,email: email)
            
        }else {
            
            showErrorAlert("Field missing",msg: "We can't proceed because one of the fields is blank. Please note that all fields are required.")
            return
            
        }
        
        
        
        
        
    }
    
    @IBAction func OnTapOnLogin(_ sender: Any) {
        
        
        
        if let pwd = passwordField.text , let username =
            usernameField.text,(pwd.characters.count > 0 &&
            username.characters.count > 0 ){
            
            self.loginUser(username: username ,password: pwd)
            
            
        }else {
            
          showErrorAlert("Field missing",msg: "We can't proceed because one of the fields is blank. Please note that all fields are required.")
            return
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func loginUser(username: String , password:String) {
        
        
        PFUser.logInWithUsername(inBackground: username, password:
        password) { (user: PFUser?, error: Error?) in
            if let error = error {
                
                self.showErrorAlert("Error ",msg:
                    "\(error.localizedDescription)")
                return
                
            } else {
                
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue",
                                  sender: nil)
            }
        }
    }
    


    func registerUser(username: String , password:String, email:String)
    {
        // initialize a user object
        let newUser = PFUser()
        
        
        
        // set user properties
        newUser.username = username
        newUser.email = email
        newUser.password = password
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                self.showErrorAlert("Error ",msg:
                    "\(error.localizedDescription)")
                return
                
                
                
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue",
                                  sender: nil)
            }
        }
    }


func showErrorAlert(_ title : String , msg :String) {
    
    let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alertController, animated: true, completion: nil)
    
}

}
