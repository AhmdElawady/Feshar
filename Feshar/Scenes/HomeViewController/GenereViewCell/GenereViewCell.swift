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
    
    var genre: String! {
        didSet {
            genereTitleLabel.text = genre
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
}
