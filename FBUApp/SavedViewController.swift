//
//  SavedViewController.swift
//  FBUApp
//
//  Created by Kelly Lampotang on 7/5/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit
import Parse

class SavedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pictureView: UIImageView!
    
    var saved: [PFObject]?
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.currentUser()
        saved = user!["saved"] as? [PFObject]
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func cardForIndexPath(indexPath: NSIndexPath, cell: SavedCell) -> UIImage {
        
        let save = saved![indexPath.row]
        //let post = posts![indexPath.row]
        //let imageFile = post["media"] as! PFFile
        //let imageFile = save["media"] as! PFFile
        let image = UIImage()
        /*
        imageFile.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) in
            if imageData != nil {
                cell.pictureView.image = UIImage(data: imageData!)!
            }
            else {
                print(error)
            }
        }*/
        return image
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saved?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SavedCell", forIndexPath: indexPath) as! SavedCell
        cardForIndexPath(indexPath, cell: cell)
        return cell
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
