//
//  BusinessCell.swift
//  Yelp
//
//  Created by emersonmalca on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var foodTypeLabel: UILabel!
    @IBOutlet weak var starsImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(withBusiness business: Business) {
        
        if let imageURL = business.imageURL {
            thumbnailImageView.setImageWith(imageURL)
        }
        nameLabel.text = business.name
        distanceLabel.text = business.distance
        if let starsURL = business.ratingImageURL {
            starsImageView.setImageWith(starsURL)
        }
        reviewsLabel.text = "\(business.reviewCount ?? 0) Reviews"
        addressLabel.text = business.address
        foodTypeLabel.text = business.categories
    }

}
