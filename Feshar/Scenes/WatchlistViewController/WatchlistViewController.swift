//
//  WatchlistViewController.swift
//  Feshar
//
//  Created by Awady on 3/31/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController {

    @IBOutlet weak var watchlistTableView: UITableView!
    
    
    var favorateMovies = [MovieModel]()
    
 //   var favorateMovies = allMovies.filter{$0.isFavorite == true}  //<<<<<< ADJUST
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButtonNavItem()
        setupTitleNavItem()
        registerWatchlistTableView()
        watchlistTableView.separatorStyle = .none
        fetchWatchList()
    }
    
    func registerWatchlistTableView() {
        let watchlistCellNib = UINib(nibName: "WatchlistViewCell", bundle: nil)
        watchlistTableView.register(watchlistCellNib, forCellReuseIdentifier: "WatchlistViewCell")
    }
    
    func fetchWatchList() {
        WatchList.getWatchList { (movie, error) in
            MovieModel.watchList = movie
            DispatchQueue.main.async {
                self.watchlistTableView.reloadData()
            }
        }
    }
}

// MARK: Watchlist TableView Setup
extension WatchlistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MovieModel.watchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchlistViewCell", for: indexPath) as! WatchlistViewCell
        cell.configCell(data: MovieModel.watchList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    // Swipe To Delete Setup
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let movie = MovieModel.watchList[indexPath.row]   // <<<<<<<<< ADJUST
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
       //     movie.isFavorite = false
            MovieModel.watchList.remove(at: indexPath.row)
            self.watchlistTableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
            completionHandler(true)
        }
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        return swipeActionConfig
    }
}

