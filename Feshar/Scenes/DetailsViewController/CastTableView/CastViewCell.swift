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
        guard let posterPath = data.profilePic else { return }
        guard let imageURL = URL(string: "http://image.tmdb.org/t/p/w300\(posterPath)") else { return }
        DispatchQueue.global().async {
            let imageData = try? Data(contentsOf: imageURL)
            guard let data = imageData else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.actorImage.image = image
            }}
    }
    
    func configData(data: Cast) {
        self.actorName.text = data.name
        self.character.text = data.character
        self.configImage(data: data)
    }
}
