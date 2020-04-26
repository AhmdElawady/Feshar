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
        movieBackgroundView.layer.shadowRadius = 8
        movieBackgroundView.layer.shadowOpacity = 0.5
    }
    
    func getPosterMovie (data: Movie) {
        guard let imageURL = URL(string: "http://image.tmdb.org/t/p/w300\(data.mainPoster)") else { return }
        DispatchQueue.global().async {
            let imageData = try? Data(contentsOf: imageURL)
            guard let data = imageData else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.moviePosterImage.image = image
            }}
    }
    
    func getGenreMovie(data: Movie) {
        var movieGenresName = [String]()
        GenresMovies.getGenresMovies { (genresResponse, error) in
            let movieGenresId = data.genresId
            for genreId in movieGenresId {
                for genre in genresResponse {
                    if genre.id == genreId {
                        movieGenresName.append(genre.name)
                    }}}}
        DispatchQueue.main.async {
            let movieGenre = movieGenresName.joined(separator: " | ")
            self.movieTypeLabel.text = movieGenre
        }
    }
    
    func configData(data: Movie) {
        getPosterMovie(data: data)
        getGenreMovie(data: data)
        movieNameLabel.text = data.name
        IMDBRateLabel.text = String(data.IMDBRate)
        describtionLabel.text = data.Description
    }
}
