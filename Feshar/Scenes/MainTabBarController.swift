//
//  MainTabBarController.swift
//  Feshar
//
//  Created by Awady on 4/3/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarForTabBar()
        setupTabAttributes()
    }
    
    func setupTabAttributes() {
        self.tabBar.tintColor = #colorLiteral(red: 1, green: 0.05882352941, blue: 0.1725490196, alpha: 1)
        self.tabBar.backgroundColor = #colorLiteral(red: 0.9700000286, green: 0.9700000286, blue: 0.9700000286, alpha: 1)
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1)
    }

}
