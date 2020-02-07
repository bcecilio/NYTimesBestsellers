//
//  FavoritesController.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {
    
    var favoritesView = FavoritesView()
    
    override func loadView() {
        view = favoritesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
    }
    

}
