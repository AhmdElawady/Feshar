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
    
    func configCell(data: Movie) {
        guard let imageURL = URL(string: "http://image.tmdb.org/t/p/w300\(data.mainPoster)") else { return }
        DispatchQueue.global().async {
            let imageData = try? Data(contentsOf: imageURL)
            guard let data = imageData else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.moviePosterImage.image = image
            }
        }
        movieNameLabel.text = data.name
        movieIMDBRate.text = String(format: "%.1f", data.IMDBRate)
    }
    
//    func getGenreMovie() {
//        var movieGenresNames = [String]()
//        GenresMovies.getGenresMovies { (genresResponse, error) in
//            guard let movieGenresId = self.movieDetails?.genres else {return}
//            
//            for genreId in movieGenresId {
//                for genre in genresResponse {
//                    if genre.id == genreId.id {
//                        movieGenresNames.append(genre.name)
//                    }}}}
//        DispatchQueue.main.async {
//            let movieGenre = movieGenresNames.joined(separator: " | ")
//            self.movieGenreLabel.text = movieGenre
//        }
//    }
}
