//
//  Card.swift
//  FBUApp
//
//  Created by Jedidiah Akano on 7/6/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit
import Parse

class Card: NSObject {
    
    class func cardImage(image: UIImage?, withLocation location: String?) -> Bool {
        // Create Parse object PFObject
        var successOverall = true
        let card = PFObject(className: "Card")
        
        // Add relevant fields to the object
        card["media"] = getPFFileFromImage(image) // PFFile column type
        card["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        card["location"] = location
        card["likesCount"] = 0
        card["commentsCount"] = 0
        card["price"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        card.saveInBackgroundWithBlock{(success, error) -> Void in
            if(error == nil)
            {
                //Success
                print("Success")
                
            }
            else
            {
                print("Error")
                successOverall = false
            }
        }
        
        return successOverall
        
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    
}


