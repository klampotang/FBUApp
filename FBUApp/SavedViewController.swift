//
//  SavedViewController.swift
//  FBUApp
//
//  Created by Kelly Lampotang on 7/5/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit
import Parse

class SavedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pictureView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func postForIndexPath(indexPath: NSIndexPath, cell: SavedCell) -> UIImage {
        let user = PFUser.currentUser()
        let saves = user!["saved"] as! [PFObject]
        let save = saves[indexPath.row]
        //let post = posts![indexPath.row]
        //let imageFile = post["media"] as! PFFile
        let imageFile = save["media"] as! PFFile
        let image = UIImage()
        imageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) in
            if imageData != nil {
                cell.pictureView.image = UIImage(data: imageData!)!
            }
            else {
                print(error)
            }
        }
        return image
        
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
