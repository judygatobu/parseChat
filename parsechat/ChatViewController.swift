//
//  ChatViewController.swift
//  parsechat
//
//  Created by Judy Gatobu on 3/6/18.
//  Copyright © 2018 Judy Gatobu. All rights reserved.
//

import UIKit
import Parse


class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
  var projectID: String!
    @IBOutlet weak var chatMessageField: UITextField!
    
    var messArray:[PFObject]!
    
    @IBAction func onTapOnSend(_ sender: Any) {
    }
    
    @IBOutlet var v: UIView!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        
        tableView.separatorStyle = .none

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath:
        IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "ChatCell", for: indexPath) as! ChatTableViewCell
        
        
        let text = messArray[indexPath.row]
        
        cell.ChatLabel.text = text["text"] as! String
        
        if let user = text["user"] as? PFUser {
            cell.ChatUsernameLabel.text = user.username
        }else {
            cell.ChatUsernameLabel.text = "�"
        }
        
        return cell
    }
    
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection
        section: Int) -> Int {
        
        
        if messArray != nil {
            return messArray.count
        }
        return 0
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    @objc func onTimer() {
        // Add code to be run periodically
        fetchMessage()
    }

    
    func fetchMessage() {
        
        var query = PFQuery(className: "Message")
        
        //sort result
        query.addDescendingOrder("createdAt")
        // add user to query
        query.includeKey("user")
        
        
        query.findObjectsInBackground { (object, error) in
            if error == nil {
                print(object)
                
                self.messArray = object
                
                
                print( object?[2]["text"])
                self.tableView.reloadData()
                
                print(object)
                
            } else {
                print(error)
            }
        }
    }


    @IBAction func send(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        
        //  store text in a text field
        chatMessage["text"] = chatMessageField.text ?? ""
        //usernaeme
        chatMessage["user"] = PFUser.current()
        //call savein a background to save message
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                
                //clear text in textcatfiled
                self.chatMessageField.text = ""
                self.projectID =  chatMessage.objectId
                self.fetchMessage()
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
    }
    
    @IBAction func ontapfield(_ sender: Any) {
         chatMessageField.becomeFirstResponder()
    }
    
 
    @IBAction func ontaponView(_ sender: Any) {
        tableView.becomeFirstResponder()
        chatMessageField.endEditing(true)
    }
    


    @IBAction func logOut(_ sender: Any) {
        
        PFUser.logOutInBackground { (error) in
            // PFUser.current() will now be nil
            self.performSegue(withIdentifier: "LogOutSegue", sender: self)
    }
    }

}


