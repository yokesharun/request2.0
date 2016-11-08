//
//  SectionCollectionViewCell.swift
//  request2.0
//
//  Created by yokesh on 11/8/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

class SectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var SectionButton: UIButton!
    
    @IBAction func onClickSection(_ sender: Any) {

        let row : Int = SectionButton.tag
        let title : String = (SectionButton.titleLabel?.text)!
        print(row)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let secondViewController = storyBoard.instantiateViewController(withIdentifier: "SectionUINav") as! SectionUINavigationController
        let detailController: SectionViewController = secondViewController.topViewController as! SectionViewController
        secondViewController.SectionID = row
        secondViewController.SectionTitle = title
        detailController.ViewID = row
        detailController.ViewTitle = title
        
        self.window?.rootViewController?.present(secondViewController, animated: true, completion: nil)
        
        
    }
    
}
