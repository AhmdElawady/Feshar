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
    
    var watchlisted = [Movie]()
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
            self.watchlisted = movie
            DispatchQueue.main.async {
                self.watchlistTableView.reloadData()
            }}}
}

// MARK: Watchlist TableView Setup
extension WatchlistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        watchlisted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchlistViewCell", for: indexPath) as! WatchlistViewCell
        cell.configCell(data: watchlisted[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    // Swipe To Delete Setup
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let movieId = watchlisted[indexPath.row].id  // <<<<<<<<< ADJUST
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            AddWatchList.addToWatchlist(mediaId: movieId, isWatchlist: false) { (response, error) in
                DispatchQueue.main.async {
                    self.watchlisted.remove(at: indexPath.row)
                    self.watchlistTableView.deleteRows(at: [indexPath], with: .automatic)
                    tableView.reloadData()
                }
                self.watchlisted[indexPath.row].isWatchlisted = false
            }
            completionHandler(true)
        }
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        return swipeActionConfig
    }
}

