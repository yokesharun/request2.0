//
//  RegisterViewController.swift
//  request2.0
//
//  Created by yokesh on 9/30/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onRegisterUser(_ sender: AnyObject) {
        
        if(emailInput.text == "" || passwordInput.text == "" || usernameInput.text == ""){
            displayNewAlert(AlertMessage: "All Fields are Required")
        }else{
            
            print("newdata\(emailInput.text)")
            
            let parameters: Parameters = [
                "device_type": "ios",
                "device_token": "token",
                "login_by" : "web",
                "email" : emailInput.text!,
                "password" : passwordInput.text!,
                "username" : usernameInput.text!
            ]
            
            Alamofire.request("http://6gag.co/v1/register",method: .post, parameters:parameters).responseJSON { response in
                
                if let json = response.result.value as? [String: Any] {
                    print("newdata\(json)")
                    
                    if(json["success"] as! Bool == true){
                        self.displayNewAlert(AlertMessage: "Registered in SuccessFull ! Login here")
                        let secondViewController:ViewController = ViewController()
                        self.present(secondViewController, animated: true, completion: nil)
                        
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
