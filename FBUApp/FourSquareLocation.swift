//
//  FourSquareLocation.swift
//  FBUApp
//
//  Created by Jedidiah Akano on 7/6/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit

class FourSquareClient: NSObject {
    var results: NSArray = []
    var location: String?
    let CLIENT_ID = "VM3U2MOM4P4IOVBQMZW5NSQH1MJEANGW51YA4SVMW4JLAEBH"
    let CLIENT_SECRET = "5FHY2RUJVEW2YRHJ3J53XN5J0U2HUY5KNQMFSCHJVMQPMDUC"
    
    override init() {
        super.init()
        location = ""
        
    }
    
    func fetchLocations(query: String, near: String = "San Francisco") -> [NSArray] {
        let baseUrlString = "https://api.foursquare.com/v2/venues/search?"
        let queryString = "client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20141020&near=\(near),CA&query=\(query)"
        
        let url = NSURL(string: baseUrlString + queryString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
        let request = NSURLRequest(URL: url)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                    NSLog("response: \(responseDictionary)")
                    self.results = responseDictionary.valueForKeyPath("response.venues") as! NSArray
                }
            }
        });
       
        task.resume()
        return results as! [NSArray]


        }
}
