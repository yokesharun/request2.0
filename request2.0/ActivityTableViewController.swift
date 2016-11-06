//
//  ActivityTableViewController.swift
//  request2.0
//
//  Created by yokesh on 11/6/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

import Alamofire

class ActivityTableViewController: UITableViewController {
    
    var noti = [Activity]()
    
    var take = 10
    var skip = 0

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // check auth of user
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        if(UserDefaults.standard.value(forKey: "id") == nil){
            
            let loginview = storyBoard.instantiateViewController(withIdentifier: "LoginForm") as! ViewController
            self.present(loginview, animated:true, completion:nil)
            
        }
        
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //adding refresh button
        
        let refresh_button = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(ActivityTableViewController.refresh_activity))
        
        navigationItem.rightBarButtonItem = refresh_button
        
        init_activity()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refresh_activity(){
        init_activity()
    }
    
    func init_activity(){
        
        print("calling init")
        
        let parameters: Parameters = [
            "id": UserDefaults.standard.value(forKey: "id")!,
            "token": UserDefaults.standard.value(forKey: "token")!,
            "take" : take,
            "skip" : skip
        ]
        
        Alamofire.request("http://6gag.co/v1/notifications",method: .get, parameters:parameters).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                
                
                if(json["success"] as! Bool == true){
                    
                    guard let results = json["data"] as? [[String:AnyObject]] else { return }
                    
                    for result in results {
                        
                        
                        print(result["time_ago"])
                        let each_act = Activity()
                        
                        each_act.user_image = result["user_details"]?["avatar"] as! String
                        each_act.gag_image = result["gag_image"] as! String
                        each_act.time_ago = result["time_ago"] as! String
                        if(result["type"] as! String == "GAG_UP"){
                            each_act.content = "\(result["user_details"]?["username"] as! String) Upvoted the Gag"
                        }else if(result["type"] as! String == "GAG_DN"){
                            each_act.content = "\(result["user_details"]?["username"] as! String) Downvoted the Gag"
                        }else if(result["type"] as! String == "COM_UP"){
                            each_act.content = "\(result["user_details"]?["username"] as! String) Upvoted the Comment"
                        }else if(result["type"] as! String == "COM_DN"){
                            each_act.content = "\(result["user_details"]?["username"] as! String) Downvoted the Comment"
                        }else if(result["type"] as! String == "COM"){
                            each_act.content = "\(result["user_details"]?["username"] as! String) Commented on the Gag"
                        }else if(result["type"] as! String == "COM_RPY"){
                            each_act.content = "\(result["user_details"]?["username"] as! String) Replied on your Comment"
                        }
                        
                        self.noti.append(each_act)
                    }
                    
                    self.tableView.reloadData()
                    
                    
                    
                }else if(json["success"] as! Bool == false){
                    self.displayNewAlert(AlertMessage: json["error_messages"] as! String!)
                }
            }
        }
        
        print("counting \(noti.count)")
    
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
        return noti.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityTableViewCell
        
        let activity = noti[indexPath.row]
        
        cell.activityContent.text = activity.content
        cell.activityTimeAgo.text = activity.time_ago
        let url = NSURL(string: activity.gag_image )
        let data = NSData(contentsOf: url! as URL)
        cell.gagImageView.image = UIImage(data: data as! Data )

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = noti.count - 1
        if(indexPath.row == lastElement){
            skip = take
            take = take + 10
            
            init_activity()
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
    
    class Activity {
        var user_image = ""
        var gag_image = ""
        var time_ago = ""
        var content = ""
    }

}
