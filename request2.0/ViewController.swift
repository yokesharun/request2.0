//
//  ViewController.swift
//  request2.0
//
//  Created by yokesh on 9/29/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var ipLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(_ sender: AnyObject) {
        
        if(emailField.text == "" || passwordField.text == ""){
            displayNewAlert(AlertMessage: "All Fields are Required")
        }else{
            
            print("newdata\(emailField.text)")
            
            let parameters: Parameters = [
                "device_type": "web",
                "device_token": "token",
                "login_by" : "web",
                "email" : emailField.text!,
                "password" : passwordField.text!
            ]
            
            Alamofire.request("http://6gag.co/v1/login",method: .post, parameters:parameters).responseJSON { response in
                
                if let json = response.result.value as? [String: Any] {
                    print("newdata\(json)")
                    
                    if(json["success"] as! Bool == true){
                        self.displayNewAlert(AlertMessage: "Logged in SuccessFull")
                    }else if(json["success"] as! Bool == false){
                        self.displayNewAlert(AlertMessage: json["error_messages"] as! String!)
                    }
                }
            }
            
        }
        
    }
    
    
    func displayNewAlert(AlertMessage:String!){
        let alert = UIAlertController(title: "Alert", message: AlertMessage, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }

}

