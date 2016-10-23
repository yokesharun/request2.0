//
//  AddGagViewController.swift
//  request2.0
//
//  Created by yokesh on 10/23/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

import Alamofire

class AddGagViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var category_picker: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    var picker_value = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(AddGagViewController.save_button) )
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddGagViewController.cancel_button) )
        
        navigationItem.rightBarButtonItem = save
        navigationItem.leftBarButtonItem = cancel

        // Do any additional setup after loading the view.
        
        // Connect data:
        category_picker.delegate = self
        category_picker.dataSource = self
        
//        let defaults = UserDefaults.standard
        
        print(UserDefaults.standard.value(forKey: "id")!)
        
        let parameters: Parameters = [
            "id": UserDefaults.standard.value(forKey: "id")!,
            "token": UserDefaults.standard.value(forKey: "token")!
        ]
        
        Alamofire.request("http://6gag.co/v1/sections",method: .get, parameters:parameters).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                
                if(json["success"] as! Bool == true){
                    
                    guard let results = json["sections"] as? [[String:AnyObject]] else { return }
                    
                    for result in results {
                        print(result["name"])
                        
                        self.pickerData.append(result["name"] as! String)
                        
                    }
                    //self.pick.reloadData()
                    
                    self.category_picker.reloadAllComponents()
                    
                    
                }else if(json["success"] as! Bool == false){
                    self.displayNewAlert(AlertMessage: json["error_messages"] as! String!)
                }
            }
        }
        
        
        
        // Input data into the Array:
        pickerData = []
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker_value = row
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func save_button(){
    
    }
    
    func cancel_button(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PostNav") as! PostUINavigationController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    func displayNewAlert(AlertMessage:String!){
        let alert = UIAlertController(title: "Alert", message: AlertMessage, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
