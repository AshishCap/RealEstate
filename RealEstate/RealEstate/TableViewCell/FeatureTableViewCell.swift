//
//  FeatureTableViewCell.swift
//  RealEstate
//
//  Created by ashish on 6/4/19.
//  Copyright © 2019 Technical. All rights reserved.
//

import UIKit

class FeatureTableViewCell: UITableViewCell
{
    @IBOutlet var featureCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
