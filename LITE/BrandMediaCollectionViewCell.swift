//
//  IGBrandMediaCollectionViewCell.swift
//  LITE
//
//  Created by Kenichi Saito on 9/3/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import UIKit

class BrandMediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var likeIconImageView: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
