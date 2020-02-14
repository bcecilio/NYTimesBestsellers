//
//  ViewController.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import DataPersistence
import ImageKit

class ViewController: UIViewController {
    
    private let initialView = NYTBestSellerView()
    private var listType = List.categories
    private let dataPersistence: DataPersistence<Book>
    
    private var books = [Book]() {
        didSet {
            DispatchQueue.main.async {
                self.initialView.collectionView.reloadData()
            }
        }
    }
    
    init(_ dataPersistence: DataPersistence<Book>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = initialView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialView.collectionView.delegate = self
        initialView.collectionView.dataSource = self
        initialView.collectionView.register(BestsellerCell.self, forCellWithReuseIdentifier: "bestsellerCell")
        initialView.pickerView.delegate = self
        initialView.pickerView.dataSource = self
        loadBooks(string: List.encodedCategories[0])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func loadBooks(string: String) {
        let endpoint = "https://api.nytimes.com/svc/books/v3/lists/current/\(string).json?api-key=\(NYTKey.key)"
        GenericCoderAPI.manager.getJSON(objectType: ListWrapper.self, with: endpoint) { (result) in
            switch result {
            case .failure(let appError):
                print("could not load data: \(appError)")
            case .success(let wrapper):
                self.books = wrapper.list.books
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bestsellerCell", for: indexPath) as? BestsellerCell else {
            fatalError("could not downcast BestsellerCell")
        }
        cell.backgroundColor = .white
        cell.configureCell(book: books[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 1
        let itemHeight:CGFloat = maxSize.height * 0.50
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1 ) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return List.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return List.categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        loadBooks(string: List.encodedCategories[row])
    }
}
