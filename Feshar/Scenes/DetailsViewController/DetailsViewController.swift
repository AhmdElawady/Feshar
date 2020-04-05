//
//  DetailsViewController.swift
//  Feshar
//
//  Created by Awady on 3/29/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var posterimageCollectionView: UICollectionView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieIMDBLabel: UILabel!
    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var castTableView: UITableView!
    @IBOutlet weak var addWishListButton: UIButton!
    
    var movie: MovieModel!
    var posters = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setupDetailsVCContent()
        registerScrollable()
        setupAddWatchlistBtn()
    }
    
// MARK: Setup Details ViewController
    func setupDetailsVCContent() {
        movieNameLabel.text = movie.name
        movieGenreLabel.text = movie.genre
        movieIMDBLabel.text = String(movie.IMDBRate ?? 0)
        describtionLabel.text = movie.Description
        posters = movie.posters ?? [UIImage(contentsOfFile: "logoP")!]
        posters.insert(movie.mainPoster ?? UIImage(named: "logoP")!, at: 0)
    }
    
    func setupAddWatchlistBtn() {
        addWishListButton.setupButtonView()
        if movie.isFavorite {   //- if turned favorite from Home TableViewCell
            addWishListButton.layer.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            addWishListButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            addWishListButton.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            addWishListButton.setTitle("ALREADY IN WATCHLIST", for: .normal)
        }
    }
    
    @IBAction func addWishListButtonPressed(_ sender: Any) {
        if movie.isFavorite == false {
            addWishListButton.layer.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            addWishListButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            addWishListButton.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            addWishListButton.setTitle("ADDED", for: .normal)
            movie.isFavorite = true
        } else {
            addWishListButton.setupButtonView()
            addWishListButton.setTitle("ADD TO WATCHLIST", for: .normal)
            movie.isFavorite = false
        }
    }
    
    func registerScrollable() {
        let CastViewCell = UINib(nibName: "CastViewCell", bundle: nil)
        let PosterImageCollectionViewCell = UINib(nibName: "PosterImageCollectionViewCell", bundle: nil)
        castTableView.register(CastViewCell, forCellReuseIdentifier: "CastViewCell")
        posterimageCollectionView.register(PosterImageCollectionViewCell, forCellWithReuseIdentifier: "PosterImageCollectionViewCell")
    }
}
    
// MARK: Posters Collection Delegates
extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterImageCollectionViewCell", for: indexPath) as! PosterImageCollectionViewCell
        cell.image = posters[indexPath.item]
        return cell
    }
}

// MARK: Posters Collection FlowLayout
extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 330, height: collectionView.frame.size.height)
    }
    // Setup Carusal effect for Posters CollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellScale: CGFloat = 0.8
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        let layout = self.posterimageCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        return UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.posterimageCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}


// MARK: TableView Setup
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CastViewCell", for: indexPath) as! CastViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

