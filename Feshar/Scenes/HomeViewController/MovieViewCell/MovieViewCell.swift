//
//  MovieViewCell.swift
//  Feshar
//
//  Created by Awady on 3/30/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {
    
    @IBOutlet weak var movieBackgroundView: UIView!
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    @IBOutlet weak var IMDBRateLabel: UILabel!
    @IBOutlet weak var describtionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellSetup()
    }
    
    func cellSetup() {
        movieBackgroundView.layer.cornerRadius = 10
        moviePosterImage.layer.cornerRadius = 10
        moviePosterImage.layer.masksToBounds = true
        moviePosterImage.clipsToBounds = true
        
        movieBackgroundView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        movieBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        movieBackgroundView.layer.shadowRadius = 8
        movieBackgroundView.layer.shadowOpacity = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configData(data: MovieModel) {
        moviePosterImage.image = data.mainPoster
        movieNameLabel.text = data.name
        movieTypeLabel.text = data.genre
        IMDBRateLabel.text = String(data.IMDBRate ?? 0)
        describtionLabel.text = data.Description
    }
    
}