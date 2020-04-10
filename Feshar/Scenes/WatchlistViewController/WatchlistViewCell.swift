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
 //       moviePosterImage.image = data.mainPoster    //<<<<<<<< ADJUST
        movieNameLabel.text = data.name
        movieIMDBRate.text = String(format: "%.1f", data.IMDBRate)
 //       movieGenreLabel.text = data.genre   //<<<<<<<<< ADJUST
    }
    
}
