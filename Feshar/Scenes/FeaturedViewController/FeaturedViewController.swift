//
//  FeaturedViewController.swift
//  Feshar
//
//  Created by Awady on 4/2/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController {

    @IBOutlet weak var featureTableView: UITableView!
    @IBOutlet weak var featureItemBar: UITabBarItem!
    
    var movieCategorized = [MovieModel]()
    var movieGenres = ["NEW", "TRENDING" ,"ACTION", "ROMANCE", "COMEDY"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        registerScrollable()
        fetchMovies()
    }
    
    func fetchMovies() {
        HomeService.sharedInstance.fetchHomeJson { (result) in
            switch result {
            case .success(let movies):
                self.movieCategorized = movies
                DispatchQueue.main.async {
                    self.featureTableView.reloadData()
                }
                
            case .failure(let error):
                print("Fail to fetch Movies data", error)
            }
        }
    }
    
    func registerScrollable() {
        let featuresTableViewCell = UINib(nibName: "FeaturesTableViewCell", bundle: nil)
        featureTableView.register(featuresTableViewCell, forCellReuseIdentifier: "FeaturesTableViewCell")
    }
}

// MARK: Featured TableView Setup
extension FeaturedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieGenres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturesTableViewCell", for: indexPath) as! FeaturesTableViewCell
        // Classify Movies By Genre
        var genre = [MovieModel]()
//        for movie in allMovies {
//            if movie.genre?.components(separatedBy: " ").first?.uppercased() == movieGenres[indexPath.row] {
//                genre.append(movie)
//            }else if movieGenres[indexPath.row] == "TRENDING" {
//                genre = allMovies
//            }else if movieGenres[indexPath.row] == "NEW" {
//                genre = allMovies
//            }
//        }
 //       movieCategorized = genre
        cell.categoryTitle.text = movieGenres[indexPath.row]
        cell.fillCategorizedMovieCollectionView(with: movieCategorized)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        215
    }
}
