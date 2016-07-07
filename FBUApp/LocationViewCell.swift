//
//  LocationViewCell.swift
//  FBUApp
//
//  Created by Jedidiah Akano on 7/7/16.
//  Copyright © 2016 Kelly Lampotang. All rights reserved.
//

import UIKit
//import AFNetworking

class LocationViewCell: UITableViewCell {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var location: NSDictionary! {
        didSet {
            locationLabel.text = location["name"] as? String
            addressLabel.text = location.valueForKeyPath("location.address") as? String
            
            let categories = location["categories"] as? NSArray
            if (categories != nil && categories!.count > 0) {
                let category = categories![0] as! NSDictionary
                let urlPrefix = category.valueForKeyPath("icon.prefix") as! String
                let urlSuffix = category.valueForKeyPath("icon.suffix") as! String
                
                let url = "\(urlPrefix)bg_32\(urlSuffix)"
                iconImageView.setImageWithURL(NSURL(string: url)!)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
