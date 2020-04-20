//
//  WatchlistViewCell.swift
//  Feshar
//
//  Created by Awady on 3/31/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class WatchlistViewCell: UITableViewCell {
    
    @IBOutlet weak var watchlistBackgroundView: UIView!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieIMDBRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moviePosterImage.layer.cornerRadius = 10
        watchlistBackgroundView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    func configCell(data: Movie) {
        
        if let imageURL = URL(string: "http://image.tmdb.org/t/p/w300\(data.mainPoster)") {
            DispatchQueue.global().async {
                let imageData = try? Data(contentsOf: imageURL)
                if let data = imageData {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.moviePosterImage.image = image
                    }
                }
            }
        }
        
        movieNameLabel.text = data.name
        movieIMDBRate.text = String(format: "%.1f", data.IMDBRate)
 //       movieGenreLabel.text = data.genre   //<<<<<<<<< ADJUST
    }
    
}
