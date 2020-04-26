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
    var movies = [Movie]()
    var tvShow = [Movie]()
    
    var categories = ["Movies", "TV Shows"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        registerScrollable()
        fetchMovies()
        fetchTVShow()
    }
    
    func fetchMovies() {
        FeaturedApi.getFeaturedMovie { [weak self] (movies, error) in
            self?.movies = movies
            DispatchQueue.main.async {
                self?.featureTableView.reloadData()
            }
        }
    }
    
    func fetchTVShow() {
        FeaturedApi.getFeaturedTVShow { [weak self] (TVShows, error) in
            self?.tvShow = TVShows
            DispatchQueue.main.async {
                self?.featureTableView.reloadData()
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
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturesTableViewCell", for: indexPath) as! FeaturesTableViewCell
        
        cell.categoryTitle.text = categories[indexPath.row]
        
        if cell.categoryTitle.text == "Movies" {
            cell.fillCategorizedMovieCollectionView(with: movies)
        } else if cell.categoryTitle.text == "TV Shows" {
            cell.fillCategorizedMovieCollectionView(with: tvShow)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        215
    }
}
