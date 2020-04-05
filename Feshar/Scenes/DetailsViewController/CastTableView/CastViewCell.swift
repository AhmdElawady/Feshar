//
//  CastViewCell.swift
//  Feshar
//
//  Created by Awady on 3/30/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class CastViewCell: UITableViewCell {

    @IBOutlet weak var contentBackgroundView: UIView!
    @IBOutlet weak var actorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var image: UIImage! {didSet {actorImage.image = image}}
        contentBackgroundView.layer.cornerRadius = 7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        actorImage.layer.cornerRadius = actorImage.frame.height/2
    }
    
}
