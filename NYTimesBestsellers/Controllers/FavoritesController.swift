//
//  FavoritesController.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import DataPersistence
import ImageKit

class FavoritesController: UIViewController {
    
    private let dataPersistence: DataPersistence<Book>
    
    init(_ dataPersistence: DataPersistence<Book>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
        self.dataPersistence.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var favoritesView = FavoritesView()
    
//    var emptyView = EmptyView(title: "Saved Books", message: "There are currently no saved books.")
    
    var books = [Book]() {
        didSet {
            DispatchQueue.main.async {
                self.favoritesView.collectionView.reloadData()
            }
            if books.isEmpty {
                // set up pur empty view here
                favoritesView.collectionView.backgroundView = EmptyView(title: "Saved Books", message: "There are currently no saved Books.")
            } else {
                favoritesView.collectionView.backgroundView = nil
            }

        }
    }
    
    override func loadView() {
        view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        collectionViewExtensions()
        configureCell()
        loadBooks()
    }
    
    
    
    
    func loadBooks() {
        do {
            books = try dataPersistence.loadItems()
        } catch {
            print("could not load books")
        }
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
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as? FavoritesCell else {
            fatalError("error, could not get cell")
        }
        let book = books[indexPath.row]
        cell.backgroundColor = .systemBackground
        cell.configure(for: book)
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
            let amazonLink = self.books.first?.amazonProductURL
            guard let url = URL(string: amazonLink ?? "") else { return }
            UIApplication.shared.open(url)
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(amazonAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
}

extension FavoritesController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("book was saved")
        loadBooks()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("book was deleted")
        loadBooks()
    }
    
    
}
