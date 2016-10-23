//
//  AddGagViewController.swift
//  request2.0
//
//  Created by yokesh on 10/23/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

class AddGagViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let save = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(AddGagViewController.save_button) )
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddGagViewController.cancel_button) )
        
        navigationItem.rightBarButtonItem = save
        navigationItem.leftBarButtonItem = cancel

        // Do any additional setup after loading the view.
    }
    
    func save_button(){
    
    }
    
    func cancel_button(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PostNav") as! PostUINavigationController
        self.present(nextViewController, animated:true, completion:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
