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
    
    var allMovies = [MovieModel]()
//    var selectedMovies = [MovieModel]()
    
    var movieGenre = ["NEW", "TRENDING" ,"ACTION", "ROMANCE", "COMEDY"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        registerScrollable()
        setupSearchBar()
        //fetchMovies()
    }
    
//    func fetchMovies() {
//        HomeService.sharedInstance.fetchHomeJson { (result) in
//            switch result {
//            case .success(let movies):
//                self.allMovies = movies
//                DispatchQueue.main.async {
//                    self.moviesTableView.reloadData()
//                }
//
//            case .failure(let error):
//                print("Fail to fetch Movies data", error)
//            }
//        }
//    }
    
    func registerScrollable() {
        let genereCellNib = UINib(nibName: "GenereViewCell", bundle: nil)
        let movieCellNib = UINib(nibName: "MovieViewCell", bundle: nil)
        genereCollectionView.register(genereCellNib, forCellWithReuseIdentifier: "GenereViewCell")
        moviesTableView.register(movieCellNib, forCellReuseIdentifier: "MovieViewCell")
    }
    
    func setupSelectedGenreCell(cell: UICollectionViewCell) {
        cell.layer.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1)
        cell.layer.shadowColor = #colorLiteral(red: 0.8980392157, green: 0.2235294118, blue: 0.2078431373, alpha: 1)
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 0, height: 8)
        cell.layer.shadowRadius = 12
        cell.layer.shadowOpacity = 0.4
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
        setupSelectedGenreCell(cell: selectedCell)
        selectedCell.genereTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
//        switch selectedCell.genereTitleLabel.text {
//        case "ACTION":
//            selectedMovies = allMovies.filter({$0.genre?.components(separatedBy: " ").first == "Action"})
//        case "COMEDY":
//            selectedMovies = allMovies.filter({$0.genre?.components(separatedBy: " ").first == "Comedy"})
//        case "ROMANCE":
//            selectedMovies = allMovies.filter({$0.genre?.components(separatedBy: " ").first == "Romance"})
//        default:
//            selectedMovies = allMovies
//        }
        moviesTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let selectedCell = genereCollectionView.cellForItem(at: indexPath) as? GenereViewCell else { return } // sometime crash on deselecting on cell "NEW" so i make it optional to prevent crashing
        selectedCell.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        selectedCell.layer.shadowColor = nil
        selectedCell.genereTitleLabel.textColor = #colorLiteral(red: 0.1843137255, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        selectedCell.layer.shadowOpacity = 0
    }
}

// MARK: Genre DataSources
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieGenre.count // <<<<<< ADJUST for selectedGenre
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenereViewCell", for: indexPath) as! GenereViewCell
        cell.genre = movieGenre[indexPath.item]  // <<<<<< ADJUST
        cell.layer.cornerRadius = 10
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
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let DetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            DetailsViewController.movie = allMovies[indexPath.row]  //  SELECTEDCELL
            DetailsViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(DetailsViewController, animated: true)
        }
    }
    // <<<<<< ADJUST
    // Setup Trailing Swipe Action
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let movie = allMovies[indexPath.row]
//        let favorite = UIContextualAction(style: .normal, title: "Favorie") { (action, sourceView, completionHandler) in
//            if movie.isFavorite==false {movie.isFavorite=true} else{ movie.isFavorite = false}
//            tableView.reloadData()
//            completionHandler(true)
//        }
//        favorite.image = movie.isFavorite ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
//        favorite.backgroundColor = movie.isFavorite ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1) : .clear
//
//        let swipeActionConfig = UISwipeActionsConfiguration(actions: [favorite])
//        swipeActionConfig.performsFirstActionWithFullSwipe = false
//        return swipeActionConfig
//    }
    // Setup Leading Swipe Action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let item = self.allMovies[indexPath.row]  // SELECTEDCell
            let items: [Any] = [item.name!, item.mainPoster!]
            let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityViewController, animated: true)
        }
        action.image = UIImage(systemName: "paperplane.fill")
        action.backgroundColor = .purple
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [action])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}

// MARK: Home DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMovies.count  // SHOULD TAKES SELECTED MOVIES
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        cell.configData(data: allMovies[indexPath.row]) // SHOULD TAKES SELECTED MOVIES
        return cell
    }
}

// MARK: SearchBar Delegate
//extension HomeViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty else {
//            selectedMovies = allMovies
//            moviesTableView.reloadData()
//            return
//        }
//        selectedMovies = allMovies.filter({ (movie) -> Bool in
//            movie.name!.lowercased().contains(searchText.lowercased())
//        })
//        moviesTableView.reloadData()
//    }
//}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}



