//
//  FeaturedTableViewCell.swift
//  Feshar
//
//  Created by Awady on 4/2/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class FeaturesTableViewCell: UITableViewCell {
    @IBOutlet weak var categorieMoviesCollectionView: UICollectionView! {
        didSet {
            categorieMoviesCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var categoryTitle: UILabel!
    
    var cellCategoryTitle: String! { didSet {categoryTitle.text = cellCategoryTitle}}
    var movies = [MovieModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCategoryCollectionView()
        categorieMoviesCollectionView.delegate = self
        categorieMoviesCollectionView.dataSource = self
    }
    
    func registerCategoryCollectionView() {
        let featureCollectionCell = UINib(nibName: "FeatureCollectionCell", bundle: nil)
        categorieMoviesCollectionView.register(featureCollectionCell, forCellWithReuseIdentifier: "FeatureCollectionCell")
    }
    
    func fillCategorizedMovieCollectionView(with movies: [MovieModel]) {
        self.movies = movies
        self.categorieMoviesCollectionView.reloadData()
    }
}

// MARK: Categorized Collection Setup
extension FeaturesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCollectionCell", for: indexPath) as! FeatureCollectionCell
        cell.moviePosterImage.image = movies[indexPath.item].mainPoster
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.size.width/3)-30, height: collectionView.frame.size.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        if let DetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
//            DetailsViewController.movie = movies[indexPath.item]
//            DetailsViewController.modalPresentationStyle = .fullScreen
//            self.navigationController.pushViewController(DetailsViewController, animated: true)
//            
//        }
//    }
    
    
}
