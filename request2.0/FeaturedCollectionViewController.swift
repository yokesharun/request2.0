//
//  FeaturedCollectionViewController.swift
//  request2.0
//
//  Created by yokesh on 11/8/16.
//  Copyright © 2016 yokesh. All rights reserved.
//

import UIKit

import Alamofire

class FeaturedCollectionViewController: UIViewController {
    
    var feature = [AllFeature]()

    @IBOutlet weak var FeatureCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://6gag.co/v1/featured",method: .get).responseJSON { response in
            
            if let json = response.result.value as? [String: Any] {
                
                if(json["success"] as! Bool == true){
                    
                    guard let results = json["data"] as? [[String:AnyObject]] else { return }
                    
                    for result in results {
                        print(result["title"])
                        let singlefeature = AllFeature()
                        
                        singlefeature.title = result["title"] as! String
                        singlefeature.image = result["image"] as! String
                        
                        self.feature.append(singlefeature)
                    }
                    
                    self.FeatureCollection.reloadData()

                    
                    
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

    func displayNewAlert(AlertMessage:String!){
        let alert = UIAlertController(title: "Alert", message: AlertMessage, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
}


class AllFeature {
    var image = ""
    var title = ""
}


extension FeaturedCollectionViewController : UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feature.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCell", for: indexPath) as! FeaturedCollectionViewCell
        
        let getfeature = feature[indexPath.row]
        cell.FeatureTitle.text = getfeature.title
        let url = NSURL(string: getfeature.image )
        let data = NSData(contentsOf: url! as URL)
        cell.FeatureImage.image = UIImage(data: data as! Data )
        
        return cell
        
    }
}
