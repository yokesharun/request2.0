//
//  SectionUINavigationController.swift
//  request2.0
//
//  Created by yokesh on 11/8/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

class SectionUINavigationController: UINavigationController {
    
    var SectionTitle: String!
    var SectionID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.topItem?.title = SectionTitle
        

        // Do any additional setup after loading the view.
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
