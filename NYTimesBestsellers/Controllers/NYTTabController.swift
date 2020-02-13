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
        let vc = ViewController(dataPersistence, listType: listTypes)
        vc.tabBarItem = UITabBarItem(title: "View", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return vc
    }()
    
    private lazy var favoritesController: FavoritesController = {
        let vc = FavoritesController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "book"), tag: 1)
        return vc
    }()
    
    private lazy var settingsController: SettingsController = {
        let vc = SettingsController(dataPersistence, listType: listTypes)
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "tray"), tag: 2)
        return vc
    }()
    
    private let dataPersistence = DataPersistence<Book>(filename: "favorited-books.plist")
    
    private var listTypes = [ListType]()


    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        viewControllers = [viewController, UINavigationController(rootViewController: favoritesController), settingsController]
    }
    
    private func loadData() {
        let endpoint = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(NYTKey.key)"
        
        GenericCoderAPI.manager.getJSON(objectType: ListTypeWrapper.self, with: endpoint) { result in
            switch result {
            case .failure(let error):
                print(error)
                break
            case .success(let wrapper):
                DispatchQueue.main.async {
                    self.listTypes = wrapper.results
                }
            }
        }
    }

}

