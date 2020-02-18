//
//  BookDetailController.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import DataPersistence
import ImageKit
import SafariServices

class BookDetailController: UIViewController {
    
    private lazy var button: UIBarButtonItem = {
        let b = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(buttonPressed(_:)))
        return b
    }()
    
    private let detailView = BookDetailView()
    
    private let dataPersistence: DataPersistence<Book>
    private let book: Book
    
    init(_ dataPersistence: DataPersistence<Book>, book: Book) {
        self.dataPersistence = dataPersistence
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        detailView.delegate = self
        detailView.configureView(book)
        setupBarButton()
        print(book.primaryIsbn13)
    }
    
    @objc private func buttonPressed(_ sender: UIBarButtonItem) {
        if !dataPersistence.hasItemBeenSaved(book) {
            do {
                try dataPersistence.createItem(book)
                let alertvc = UIAlertController(title: "Saved", message: "Item has been saved.", preferredStyle: .alert)
                alertvc.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alertvc, animated: true)
            } catch {
                let alertvc = UIAlertController.errorAlert("Error ocurred: \(error)")
                present(alertvc, animated: true, completion: nil)
            }
        } else {
            let alertvc = UIAlertController.errorAlert("Item has already been saved.")
            present(alertvc, animated: true, completion: nil)
        }
        
    }
    
    private func loadData() {
        let endpoint = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(book.primaryIsbn10)"
        GenericCoderAPI.manager.getJSON(objectType: GoogleBookWrapper.self, with: endpoint) { result in
            switch result {
            case .failure:
                break
            case .success(let wrapper):
                DispatchQueue.main.async {
                    self.detailView.configureText(wrapper.items[0].volumeInfo.description)
                }
            }
        }
    }
    
    private func setupBarButton() {
        navigationItem.setRightBarButton(button, animated: true)
    }
    
}

extension BookDetailController: BookDetailViewDelegate {
    func didPressButton(_ button: UIButton) {
        switch button.tag {
        case 0:
            guard let url = URL(string: book.amazonProductURL) else {
                present(UIAlertController.errorAlert("Could not bring up URL"), animated: true, completion: nil)
                break
            }
            
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        case 1:
            guard let url = URL(string: book.buyLinks[1].url) else {
                present(UIAlertController.errorAlert("Could not bring up URL"), animated: true, completion: nil)
                break
            }
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        default:
            break
        }
    }
}
