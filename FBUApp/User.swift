//
//  User.swift
//  FBUApp
//
//  Created by Jedidiah Akano on 7/6/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
// User model

import UIKit

class User: NSObject {
    var firstName: String?
    var lastName: String?
    var userName: String?
    var dictionary: NSDictionary?
    var age: Int = 0

    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        userName = dictionary["username"] as? String
        age = (dictionary["age"] as? Int) ?? 0
    }
    


}
