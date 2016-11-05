//
//  PostTableViewController.swift
//  request2.0
//
//  Created by yokesh on 10/4/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

import Alamofire

class PostTableViewController: UITableViewController {

    var people = [Person]()
    var take = 10
    var skip = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adding button item
        
        let add_gag = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(PostTableViewController.new_data))
        
        let clear = UIBarButtonItem(title: "clear", style: .plain, target: self, action: #selector(PostTableViewController.clear_data))
        
        navigationItem.rightBarButtonItem = add_gag
        navigationItem.leftBarButtonItem = clear
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none

        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        
        view.addSubview(myActivityIndicator)
        
        
        let parameters: Parameters = [
            "type": "fresh",
            "take": take,
            "skip" : skip
        ]
        
        

        Alamofire.request("http://6gag.co/v1/top/gag",method: .get, parameters:parameters).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                
                if(json["success"] as! Bool == true){
                    
                    guard let results = json["data"] as? [[String:AnyObject]] else { return }

                    for result in results {
                        print(result["title"])
                        let person = Person()
                        
                        person.title = result["title"] as! String
                        person.image = result["image"] as! String
                        
                        self.people.append(person)
                    }
                    self.tableView.reloadData()
                    
                    myActivityIndicator.stopAnimating()
                    
                    
                }else if(json["success"] as! Bool == false){
                    self.displayNewAlert(AlertMessage: json["error_messages"] as! String!)
                }
            }
        }
        
        //end of request
    }
    
    func clear_data(){
        
        
        UserDefaults.standard.setValue("", forKey: "id")
        UserDefaults.standard.setValue("", forKey: "token")
        UserDefaults.standard.setValue("", forKey: "avatar")
        UserDefaults.standard.setValue("", forKey: "username")
        UserDefaults.standard.setValue("", forKey: "email")
        
        self.displayNewAlert(AlertMessage: "cleared")

        
    }
    
    func new_data(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        if(UserDefaults.standard.value(forKey: "id") == nil){
            
            let loginview = storyBoard.instantiateViewController(withIdentifier: "LoginForm") as! ViewController
            self.present(loginview, animated:true, completion:nil)
        
        
        }else{
        
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddGagNav") as! AddGagNavigationController
            self.present(nextViewController, animated:true, completion:nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
        
        let person = people[indexPath.row]
        
        cell.titleLabel.text = person.title
        let url = NSURL(string: person.image )
        let data = NSData(contentsOf: url! as URL)
        cell.newImage.image = UIImage(data: data as! Data )
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = people.count - 1
        if(indexPath.row == lastElement){
            // append new data
            
            skip = take
            take = take + 10
            
            let parameters: Parameters = [
                "type": "fresh",
                "take": take,
                "skip" : skip
            ]
            
            
            
            Alamofire.request("http://6gag.co/v1/top/gag",method: .get, parameters:parameters).responseJSON { response in
                
                if let json = response.result.value as? [String: Any] {
                    
                    if(json["success"] as! Bool == true){
                        
                        guard let results = json["data"] as? [[String:AnyObject]] else { return }
                        
                        for result in results {
                            print(result["title"] as! String)
                            let person = Person()
                            
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
            
            
            
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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


class Person {
    var image = ""
    var title = ""
}
