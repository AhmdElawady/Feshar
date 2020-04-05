//
//  NavigationAttributes.swift
//  Feshar
//
//  Created by Awady on 4/1/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setUpNavigationBar() {
        setupTitleNavItem()
        setupBackButtonNavItem()
        setupWishlistNavItem()
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9745692015, green: 0.9745692015, blue: 0.9745692015, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupTitleNavItem() {
        let title = UIImageView(image: #imageLiteral(resourceName: "logo"))
        title.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        title.contentMode = .scaleAspectFit
        navigationItem.titleView = title
    }
    
    func setupBackButtonNavItem() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.tintColor = #colorLiteral(red: 0.1843137255, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        backButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        backButton.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func setupWishlistNavItem() {
        if UIViewController.self != WatchlistViewController.self {
        let wishlistButton = UIButton(type: .custom)
        wishlistButton.setImage(UIImage(systemName: "wand.and.stars")?.withRenderingMode(.alwaysOriginal), for: .normal)
        wishlistButton.tintColor = #colorLiteral(red: 0.1843137255, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        wishlistButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        wishlistButton.addTarget(self, action: #selector(clickWishList), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: wishlistButton)
        }
    }
    
    @objc func clickWishList(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let WatchlistViewController = mainStoryboard.instantiateViewController(withIdentifier: "WatchlistViewController") as? WatchlistViewController {
            WatchlistViewController.modalPresentationStyle = .automatic
            self.navigationController?.pushViewController(WatchlistViewController, animated: true)
        }
    }
    
    @objc func clickBack(){
        navigationController?.modalPresentationStyle = .automatic
        navigationController?.popViewController(animated: true)
    }
}

extension UITabBarController {
    func setupNavBarForTabBar() {
        setUpNavigationBar()
    }
}
