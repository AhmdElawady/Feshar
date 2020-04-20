//
//  GenereViewCell.swift
//  Feshar
//
//  Created by Awady on 3/31/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class GenereViewCell: UICollectionViewCell {
    
    @IBOutlet weak var genereTitleLabel: UILabel!
//    override func prepareForReuse() {
//        super.prepareForReuse()
////        genereTitleLabel.text = nil
//        layer.masksToBounds = false
//        genereTitleLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        genereTitleLabel.textColor = #colorLiteral(red: 0.1843137255, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
//        layer.shadowRadius = 12
//
//
//    }
    
    var genreID = 0
    var genre: String! {
        didSet {
            genereTitleLabel.text = genre
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 7
        layer.masksToBounds = false
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
}
