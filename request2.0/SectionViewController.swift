//
//  SectionViewController.swift
//  request2.0
//
//  Created by yokesh on 11/8/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

import Alamofire

class SectionViewController: UITableViewController {
    
    var ViewTitle: String!
    var ViewID: Int!
    
    var people = [SectionPerson]()
    var take = 10
    var skip = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let back_button = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(SectionViewController.back_button))
        navigationItem.leftBarButtonItem = back_button
        
        
        print("awesome \(ViewID)")
        

        init_function()
        

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back_button(){
        self.dismiss(animated: true, completion: nil);
    }
    
    func init_function(){
    
        let parameters: Parameters = [
            "section_id": ViewID,
            "take": take,
            "skip" : skip
        ]
        
        Alamofire.request("http://6gag.co/v1/section/gag",method: .get, parameters:parameters).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                
                if(json["success"] as! Bool == true){
                    
                    guard let results = json["data"] as? [[String:AnyObject]] else { return }
                    
                    for result in results {
                        print(result["title"])
                        let person = SectionPerson()
                        
                        person.title = result["title"] as! String
                        person.image = result["image"] as! String
                        
                        self.people.append(person)
                    }
                    self.tableView.reloadData()
                    
                    
                }else if(json["success"] as! Bool == false){
                    self.displayNewAlert(AlertMessage: json["error_messages"] as! String!)
                }
            }
        }
        
        //end of request
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! SectionTableViewCell
        
        let person = people[indexPath.row]
        
        cell.SectionGagTitle.text = person.title
        let url = NSURL(string: person.image )
        let data = NSData(contentsOf: url! as URL)
        cell.SectionGagImage.image = UIImage(data: data as! Data )
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = people.count - 1
        if(indexPath.row == lastElement){
            // append new data
            
            skip = take
            take = take + 10
            
            init_function()
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func displayNewAlert(AlertMessage:String!){
        let alert = UIAlertController(title: "Alert", message: AlertMessage, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
}


class SectionPerson {
    var image = ""
    var title = ""
}
