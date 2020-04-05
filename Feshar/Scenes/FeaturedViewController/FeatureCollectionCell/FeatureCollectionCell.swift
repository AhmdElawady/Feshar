//
//  FeatureCollectionCell.swift
//  Feshar
//
//  Created by Awady on 4/2/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class FeatureCollectionCell: UICollectionViewCell {
    @IBOutlet weak var featureBackgroundView: UIView!
    @IBOutlet weak var moviePosterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        featureBackgroundView.layer.cornerRadius = 10
        moviePosterImage.layer.cornerRadius = 10
    }
}
