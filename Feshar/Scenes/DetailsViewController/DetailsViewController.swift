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
    
    var movieId = Int()
    var movieDetails: DetailsResponse?
    var posters = [UIImage]()
    var isWatchlisted: Bool?
    var cast = [Cast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        fetchDetailsMovie()
        setupDetailsVCContent()
        registerScrollable()
        setupAddWatchlistBtn()
    }
    
// MARK: Setup Details ViewController
    func fetchDetailsMovie() {
        Details.getDetails(movieId: movieId) { (details, error) in
            self.movieDetails = details
        }
    }
    
    func setupDetailsVCContent() {
        DispatchQueue.main.async {
            self.movieNameLabel.text = self.movieDetails?.name
            self.movieIMDBLabel.text = String(format: "%.1f", self.movieDetails?.IMDBRate ?? 0)
            self.describtionLabel.text = self.movieDetails?.Description
            self.updateCollectionPosters()
        }
        self.getGenreMovie()
        fetchCast()
    }
    
    func getGenreMovie() {
        var movieGenresNames = [String]()
        GenresMovies.getGenresMovies { (genresResponse, error) in
            guard let movieGenresId = self.movieDetails?.genres else {return}
            for genreId in movieGenresId {
                for genre in genresResponse {
                    if genre.id == genreId.id {
                        movieGenresNames.append(genre.name)
                    }
                }
            }
        }
        DispatchQueue.main.async {
            let movieGenre = movieGenresNames.joined(separator: " | ")
            self.movieGenreLabel.text = movieGenre
        }
    }
    
    func updateCollectionPosters() {
        guard let posterPath = movieDetails?.mainPoster else { return }
        if let imageURL = URL(string: "http://image.tmdb.org/t/p/w300\(posterPath)") {
            DispatchQueue.global().async {
                let imageData = try? Data(contentsOf: imageURL)
                if let data = imageData {
                    guard let image = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.posters.append(image)
                        self.posterimageCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func fetchCast() {
        Credit.getCast(movieId: movieId) { (cast, error) in
            self.cast = cast
            DispatchQueue.main.async {
                self.castTableView.reloadData()
            }
        }
    }
    
// MARK: Setup Button attributes
    func setupAddWatchlistBtn() {
        addWishListButton.setupButtonView()
        if MovieModel.watchList.contains(where: {$0.id == movieDetails?.id}) == true {
            addWishListButton.layer.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            addWishListButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            addWishListButton.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            addWishListButton.setTitle("ALREADY IN WATCHLIST", for: .normal)
            isWatchlisted = true
        } else {
            isWatchlisted = false
        }
    }
    
    @IBAction func addWishListButtonPressed(_ sender: Any) {
        if isWatchlisted == false {
            AddWatchList.addToWatchlist(mediaId: movieDetails!.id, isWatchlist: true) { (response, error) in
                DispatchQueue.main.async {
                    self.addWishListButton.layer.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                    self.addWishListButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    self.addWishListButton.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                    self.addWishListButton.setTitle("ADDED", for: .normal)
                    self.isWatchlisted = true
                }
            }
        } else {
            AddWatchList.addToWatchlist(mediaId: movieDetails!.id, isWatchlist: false) { (response, error) in
                DispatchQueue.main.async {
                    self.addWishListButton.setupButtonView()
                    self.addWishListButton.setTitle("ADD TO WATCHLIST", for: .normal)
                    self.isWatchlisted = false
                }
            }
            
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

//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.posterimageCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        let roundedIndex = round(index)
//        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//    }
}


// MARK: TableView Setup
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CastViewCell", for: indexPath) as! CastViewCell
        cell.configData(data: cast[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

