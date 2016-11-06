//
//  AddGagViewController.swift
//  request2.0
//
//  Created by yokesh on 10/23/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

import Alamofire

class AddGagViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var category_picker: UIPickerView!
    @IBOutlet weak var gagImageView: UIImageView!
    
    var pickerData:[(id: Int, name: String)] = []
    
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
        

        
        let parameters: Parameters = [
            "id": UserDefaults.standard.value(forKey: "id")!,
            "token": UserDefaults.standard.value(forKey: "token")!
        ]
        
        Alamofire.request("http://6gag.co/v1/sections",method: .get, parameters:parameters).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                
                if(json["success"] as! Bool == true){
                    
                    guard let results = json["sections"] as? [[String:AnyObject]] else { return }
                    
                    for result in results {
                        
                        let id = result["id"] as! Int
                        
                        let name = result["name"] as! String
                        
                        self.pickerData.append((id,name))
        
                        
                    }
                    
                    print(" id \(self.pickerData)")
                    
                    self.category_picker.reloadAllComponents()
                    
                    
                }else if(json["success"] as! Bool == false){
                    self.displayNewAlert(AlertMessage: json["error_messages"] as! String!)
                }
            }
        }
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(pickerData[row].name)
        return pickerData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        picker_value = pickerData[row].id

//        inputTaxRate.text = stateInfo[row].tax
        print( "some data \(picker_value)")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func save_button(){
        
        let URL = "http://6gag.co/v1/create/gag"

        
        // uploading a new image here
        
        
        
        
    }
    
    func cancel_button(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MasterTabView") as! TabViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    func displayNewAlert(AlertMessage:String!){
        let alert = UIAlertController(title: "Alert", message: AlertMessage, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }

    
    @IBAction func selectImagePicker(_ sender: AnyObject) {
        let myImagePicker = UIImagePickerController()
        myImagePicker.delegate = self
        myImagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        gagImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
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
