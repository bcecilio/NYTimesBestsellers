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
import SafariServices

class FavoritesController: UIViewController {
    
    private let dataPersistence: DataPersistence<Book>
    
    public init(_ dataPersistence: DataPersistence<Book>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
        self.dataPersistence.delegate = self
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var favoritesView = FavoritesView()
    
    private var books = [Book]() {
        didSet {
            self.favoritesView.collectionView.reloadData()
            if books.isEmpty {
                favoritesView.collectionView.backgroundView = EmptyView(title: "Saved Books", message: "There are currently no saved Books.")
            } else {
                favoritesView.collectionView.backgroundView = nil
            }
            
        }
    }
    
    override func loadView() {
        super.loadView()
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
    
    
    
    
    private func loadBooks() {
        do {
            books = try dataPersistence.loadItems()
        } catch {
            let alertvc = UIAlertController.errorAlert("Could not load books")
            present(alertvc, animated: true, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        let detailVC = BookDetailController(dataPersistence, book: book)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FavoritesController: FavoritesCellDelegate {
    func moreButtonPressed(_ favoritesCell: FavoritesCell, book: Book) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in
            self.deleteBook(book)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let amazonAction = UIAlertAction(title: "View on Amazon", style: .default) { alertAction in
            guard let url = URL(string: book.amazonProductURL) else {
                self.present(UIAlertController.errorAlert("Could not bring up URL"), animated: true, completion: nil)
                return
            }
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true)
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(amazonAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func deleteBook(_ book: Book) {
        guard let index = books.firstIndex(of: book) else {
            return
        }
        do {
            try dataPersistence.deleteItem(at: index)
        } catch {
            print("error: \(error)")
        }
    }
    
}

extension FavoritesController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadBooks()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        loadBooks()
    }
    
    
}
