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
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var character: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var image: UIImage! {didSet {actorImage.image = image}}
        contentBackgroundView.layer.cornerRadius = 7
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        actorImage.layer.cornerRadius = actorImage.frame.height/2
    }
    
    func configImage(data: Cast) {
        if let imageURL = URL(string: "http://image.tmdb.org/t/p/w300\(data.profilePic)") {
            DispatchQueue.global().async {
                let imageData = try? Data(contentsOf: imageURL)
                if let data = imageData {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.actorImage.image = image
                    }
                }
            }
        }
    }
    
    func configData(data: Cast) {
        actorName.text = data.name
        character.text = data.character
        configImage(data: data)
    }
    
}
