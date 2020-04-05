//
//  PosterImageCollectionViewCell.swift
//  Feshar
//
//  Created by Awady on 3/29/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class PosterImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterCell: UIImageView!
    
    var image: UIImage! {
        didSet {
            posterCell.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterCell.layer.cornerRadius = 12
    }
}
