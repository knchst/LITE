//
//  BrandTableViewCell.swift
//  LITE
//
//  Created by Kenichi Saito on 9/3/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import UIKit
import IoniconsKit

class BrandTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var mediasCollectionView: UICollectionView!
    
    var brand: IGBrand!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension BrandTableViewCell {
    fileprivate func setup() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height / 2
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.borderWidth = 0.5
        self.profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.mediasCollectionView.dataSource = self
        let nib = UINib(nibName: "BrandMediaCollectionViewCell", bundle: nil)
        self.mediasCollectionView.register(nib, forCellWithReuseIdentifier: "BrandMediaCollectionViewCell")
    }
    
    func set(data: IGBrand) {
        self.brand = data
        self.fullNameLabel.text = self.brand.fullName
        self.usernameLabel.text = "@\(self.brand.username)"
        let url = URL(string: self.brand.profilePicUrlHd)!
        self.profileImageView.kf.setImage(with: url)
        
        self.mediasCollectionView.reloadData()
    }
}

extension BrandTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.brand.medias.filter("isVideo == %@", false).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandMediaCollectionViewCell", for: indexPath) as! BrandMediaCollectionViewCell
        let media = self.brand.medias[indexPath.row]
        let url = URL(string: media.src)!
        cell.mediaImageView.kf.setImage(with: url)
        cell.likeIconImageView.image = UIImage.ionicon(with: .heart, textColor: UIColor(red:0.93, green:0.29, blue:0.34, alpha:1.0), size: CGSize(width: 21, height: 21))
        cell.likeCountLabel.text = "\(media.likes)"
        return cell
    }
}

extension BrandTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}
