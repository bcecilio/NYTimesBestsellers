//
//  FavoritesController.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesController: UIViewController {
    
    private let dataPersistence: DataPersistence<Book>
    
    init(_ dataPersistence: DataPersistence<Book>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var favoritesView = FavoritesView()
    
    var emptyView = EmptyView(title: "Saved Books", message: "There are currently no saved books.")
    
    override func loadView() {
        view = emptyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        navigationItem.title = "Favorites"
        collectionViewExtensions()
        configureCell()
    }
    
    func collectionViewExtensions() {
        favoritesView.collectionView.dataSource = self
        favoritesView.collectionView.delegate = self
    }
    
    func configureCell() {
        favoritesView.collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: "favoritesCell")
    }
    
    
    
}

extension FavoritesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as? FavoritesCell else {
            fatalError("error, could not get cell")
        }
        cell.backgroundColor = .systemBackground
        cell.delegate = self
        return cell
    }
    
}

extension FavoritesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width / 1.2
        let itemHeight: CGFloat = maxSize.height * 0.40
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension FavoritesController: FavoritesCellDelegate {
    func moreButtonPressed(_ favoritesCell: FavoritesCell) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let amazonAction = UIAlertAction(title: "View on Amazon", style: .default) { alertAction in
            guard let url = URL(string: "https://www.amazon.com/Digital-Minimalism-Choosing-Focused-Noisy/dp/0525536515/ref=asc_df_0525536515/?tag=hyprod-20&linkCode=df0&hvadid=312143020546&hvpos=1o1&hvnetw=g&hvrand=17488743285732611120&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9004331&hvtargid=pla-562513904368&psc=1") else { return }
            UIApplication.shared.open(url)
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(amazonAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
        
}
