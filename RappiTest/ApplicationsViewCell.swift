//
//  ApplicationsViewCell.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit

class ApplicationsViewCell: UITableViewCell {

    @IBOutlet weak var backViewContainer: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var categorylabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backViewContainer.layer.cornerRadius = 10.0
        backViewContainer.layer.borderColor  = UIColor.rappidGrayColor().cgColor
        backViewContainer.layer.borderWidth  = 1.0
        
        priceLabel.textColor = UIColor.white
        
        priceLabel.layer.borderWidth   = 1
        priceLabel.layer.masksToBounds = false
        priceLabel.layer.borderColor   = UIColor.rappiGreenColor().cgColor
        priceLabel.layer.cornerRadius  = (priceLabel.frame.height)/2
        priceLabel.clipsToBounds       = true
        priceLabel.backgroundColor     = UIColor.rappiGreenColor()
        
        pictureView?.layer.borderWidth = 1
        pictureView?.layer.masksToBounds = false
        pictureView?.layer.borderColor = UIColor.white.cgColor
        pictureView?.layer.cornerRadius = (pictureView.frame.height)/2
        pictureView?.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
