//
//  NYTTabController.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class NYTTabController: UITabBarController {
    
    private lazy var viewController: ViewController = {
        let vc = ViewController()
        vc.tabBarItem = UITabBarItem(title: "View", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return vc
    }()
    
    private lazy var favoritesController: FavoritesController = {
        let vc = FavoritesController()
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "book"), tag: 1)
        return vc
    }()
    
    private lazy var settingsController: SettingsController = {
        let vc = SettingsController()
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "tray"), tag: 2)
        return vc
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [viewController, UINavigationController(rootViewController: favoritesController), settingsController]
    }

}

