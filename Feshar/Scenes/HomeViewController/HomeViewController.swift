//
//  HomeViewController.swift
//  Feshar
//
//  Created by Awady on 3/30/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var genereCollectionView: UICollectionView!
    @IBOutlet weak var moviesTableView: UITableView!
    
    var allMovies = [Movie]()
    var filteredMovies = [Movie]()
    var genres = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        registerScrollable()
        setupSearchBar()
        fetchMovies()
        fetchGenres()
    }
    
    func fetchMovies() {
        Movies.getAllMovies { [weak self] (movie, error) in
            self?.allMovies = movie
            self?.filteredMovies = movie
            MovieModel.allMovies = movie
            DispatchQueue.main.async {
                self?.moviesTableView.reloadData()
            }
        }
    }
    
    func fetchGenres() {
        GenresMovies.getGenresMovies { (genres, error) in
            self.genres = genres
        }
    }
    
    func registerScrollable() {
        let genereCellNib = UINib(nibName: "GenereViewCell", bundle: nil)
        let movieCellNib = UINib(nibName: "MovieViewCell", bundle: nil)
        genereCollectionView.register(genereCellNib, forCellWithReuseIdentifier: "GenereViewCell")
        moviesTableView.register(movieCellNib, forCellReuseIdentifier: "MovieViewCell")
    }
    
    func setupSearchBar() {
        movieSearchBar.searchBarStyle = .minimal
        movieSearchBar.searchTextField.delegate = self
    }
}

// MARK: Genre Delegates
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = genereCollectionView.cellForItem(at: indexPath) as! GenereViewCell
        selectedCell.isSelected = true
        setupSelectedGenreCell(cell: selectedCell)
        selectedCell.genereTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        filteredMovies = allMovies.filter { (movie) -> Bool in
            movie.genresId.contains(genres[indexPath.item].id)}
        moviesTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let deSelectedCell = genereCollectionView.cellForItem(at: indexPath) as? GenereViewCell else { return }
        setupDefaultGenreCell(cell: deSelectedCell)
        deSelectedCell.isSelected = false
        deSelectedCell.genereTitleLabel.textColor = #colorLiteral(red: 0.1843137255, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
    }
    
    func setupSelectedGenreCell(cell: UICollectionViewCell) {
        cell.layer.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1)
        cell.layer.shadowColor = #colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1)
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 0, height: 8)
        cell.layer.shadowOpacity = 0.4
    }
    
    func setupDefaultGenreCell(cell: UICollectionViewCell) {
        cell.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.shadowColor = nil
        cell.layer.shadowOpacity = 0
    }
}

// MARK: Genre DataSources
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenereViewCell", for: indexPath) as! GenereViewCell
        
        if cell.isSelected {
            setupSelectedGenreCell(cell: cell)
            cell.genereTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        } else {
            setupDefaultGenreCell(cell: cell)
            cell.genereTitleLabel.textColor = #colorLiteral(red: 0.1843137255, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        }
        
        cell.genre = genres[indexPath.item].name
        cell.genreID = genres[indexPath.item].id
        
        return cell
    }
}

// MARK: Genre DelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120 , height: 40)
    }
}

// MARK: Home Delegates
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let movieId = filteredMovies[indexPath.row].id
//        Details.getDetails(movieId: movieId) { (movie, error) in
//            DispatchQueue.main.async {
//                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                if let DetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
//                    DetailsViewController.movie = movie
//                    DetailsViewController.modalPresentationStyle = .fullScreen
//                self.navigationController?.pushViewController(DetailsViewController, animated: true)
//                }
//            }
//        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let DetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            DetailsViewController.movieId = filteredMovies[indexPath.row].id
            DetailsViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(DetailsViewController, animated: true)
        }
    }
    
//     Setup Trailing Swipe Action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let movieId = filteredMovies[indexPath.row].id
        let addWatchlist = UIContextualAction(style: .normal, title: "Add to\nwatchlist") { (action, sourceView, completionHandler) in
            AddWatchList.addToWatchlist(mediaId: movieId, isWatchlist: true) { (response, error) in
                self.filteredMovies[indexPath.row].isWatchlisted = true
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
            completionHandler(true)
        }
        
        addWatchlist.image = self.filteredMovies[indexPath.row].isWatchlisted ?? false ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
        addWatchlist.backgroundColor = self.filteredMovies[indexPath.row].isWatchlisted ?? false ? #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [addWatchlist])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
    // Setup Leading Swipe Action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let item = MovieModel.allMovies[indexPath.row]
            let items: [Any] = [item.name!, item.mainPoster]
            let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityViewController, animated: true)
        }
        action.image = UIImage(systemName: "paperplane.fill")
        action.backgroundColor = #colorLiteral(red: 0.4420216182, green: 0.641610953, blue: 0.4412724743, alpha: 1)
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [action])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}

// MARK: Home DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        cell.configData(data: filteredMovies[indexPath.row])
        return cell
    }
}

// MARK: SearchBar Delegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredMovies = allMovies
            moviesTableView.reloadData()
            return
        }
        filteredMovies = allMovies.filter({ (movie) -> Bool in
            movie.name!.lowercased().contains(searchText.lowercased())
        })
        moviesTableView.reloadData()
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}



