//
//  UploadViewController.swift
//  FBUApp
//
//  Created by Kelly Lampotang on 7/5/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var newCard: Card?
    //ADD AN OUTLET HERE FOR IMAGE
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var priceSegControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //Turn into IBAction
    func imageFieldTapped(sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func uploadFromCamButton(sender: AnyObject) {
    }
    @IBAction func imageViewTapped(sender: AnyObject) {
    }
    @IBAction func onUpload(sender: AnyObject) {
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        //newImage.image = editedImage //TURN INTO OUTLET THING
        //Hide the button
        //promptButton.hidden = true //FIX Here
        //uploadRollButton.hidden = true //FIX HERE
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    


}
