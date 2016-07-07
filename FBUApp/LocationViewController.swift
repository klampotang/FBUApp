//
//  LocationViewController.swift
//  FBUApp
//
//  Created by Jedidiah Akano on 7/7/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit

protocol LocationsViewControllerDelegate : class {
    func locationsPickedLocation(controller: LocationViewController, latitutde: NSNumber, longitude: NSNumber)
    
}

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    let CLIENT_ID = "VM3U2MOM4P4IOVBQMZW5NSQH1MJEANGW51YA4SVMW4JLAEBH"
    let CLIENT_SECRET = "5FHY2RUJVEW2YRHJ3J53XN5J0U2HUY5KNQMFSCHJVMQPMDUC"
    weak var delegate : LocationsViewControllerDelegate!
    
    var results: NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        locationSearchBar.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationViewCell") as! LocationViewCell
        cell.location = results[indexPath.row] as! NSDictionary
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let newText = NSString(string: searchBar.text!).stringByReplacingCharactersInRange(range, withString: text)
        fetchLocations(newText)
        
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        fetchLocations(searchBar.text!)
    }
    
    func fetchLocations(query: String, near: String = "San Francisco") {
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
                    //NSLog("response: \(responseDictionary)")
                    self.results = responseDictionary.valueForKeyPath("response.venues") as! NSArray
                    self.tableView.reloadData()
                }
            }
        });
        task.resume()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let location = results[indexPath.row] as! NSDictionary
        let lat = location.valueForKeyPath("location.lat") as! NSNumber
        let long = location.valueForKeyPath("location.lng") as! NSNumber
        
        delegate.locationsPickedLocation(self, latitutde: lat, longitude: long)
        
    }

    
    

}
