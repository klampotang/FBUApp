//
//  DetailViewController.swift
//  FBUApp
//
//  Created by Kelly Lampotang on 7/5/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit
import Parse
import ParseUI
class DetailViewController: UIViewController {
    //derp
    
    var card: PFObject?

    @IBOutlet weak var estimatedPriceLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var whenSavedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cardPicture: PFImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.distanceLabel.text = String(card!["distance"])
        self.cardPicture.file = card!["media"] as? PFFile
        self.cardPicture.loadInBackground()
        self.estimatedPriceLabel.text = String(card!["price"])

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
