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
        detailView.configureView(book)
        setupBarButton()
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
    
    private func setupBarButton() {
        navigationItem.setRightBarButton(button, animated: true)
    }
    
}
