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
    var newImage : UIImage?
    
    @IBOutlet weak var buttonLibraryTapped: UIButton!
    @IBOutlet weak var buttonPromptCam: UIButton!
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

    
    @IBAction func uploadFromCamButton(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    @IBAction func imageViewTapped(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        uploadImageView.image = editedImage
        newImage = editedImage
        //Hide the button
        buttonLibraryTapped.hidden = true
        buttonPromptCam.hidden = true
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onUpload(sender: AnyObject) {
        // Display HUD right before the request is made
        //MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let locationText = locationTextField.text;
        print(locationText)
        //newimage = resize(newimage!, newSize: CGSize)
        let successValue = Card.cardImage(newImage, withLocation: locationText)
        if(successValue)
        {
            // Hide HUD once the network request comes back (must be done on main UI thread)
            //MBProgressHUD.hideHUDForView(self.view, animated: true)
            //self.alert("Success")
            //cameraImage.hidden = true
            buttonLibraryTapped.hidden  = false
            buttonPromptCam.hidden = false
            //captionTextField.text = ""
        }
        else
        {
            //self.alert("Error")
        }

    }
    
    


}
