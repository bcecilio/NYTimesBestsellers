//
//  NYTTabController.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import DataPersistence

class NYTTabController: UITabBarController {
    
    private lazy var viewController: ViewController = {
        let vc = ViewController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "View", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return vc
    }()
    
    private lazy var favoritesController: FavoritesController = {
        let vc = FavoritesController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "book"), tag: 1)
        return vc
    }()
    
    private lazy var settingsController: SettingsController = {
        let vc = SettingsController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "tray"), tag: 2)
        return vc
    }()
    
    private let dataPersistence = DataPersistence<Book>(filename: "favorited-books.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: viewController), UINavigationController(rootViewController: favoritesController), settingsController]
    }
}

