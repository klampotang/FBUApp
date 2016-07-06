//
//  Card.swift
//  FBUApp
//
//  Created by Jedidiah Akano on 7/6/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit

class Card: NSObject {
    var distance: Int = 0
    var likes: Int = 0
    var postUrl: NSURL?
    var user: User!
    var id: Int?
    var location: String?
    var dictionary: NSDictionary?

    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        location = dictionary["description"] as? String
        distance = (dictionary["distance"] as? Int) ?? 0
        likes = (dictionary["likes"] as? Int) ?? 0
            
        }
        
    }



