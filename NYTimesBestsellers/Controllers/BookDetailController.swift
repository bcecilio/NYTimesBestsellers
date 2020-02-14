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
    
    private let detailView = BookDetailView()
    
    private let dataPersistence: DataPersistence<Book>
    private let book: Book
    
    init(_ dataPersistence: DataPersistence<Book>, book: Book) {
        self.dataPersistence = dataPersistence
        self.book = book
        super.init(nibName: nil, bundle: nil)
        self.detailView.delegate = self
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

        // Do any additional setup after loading the view.
    }
    
}

extension BookDetailController: BookDetailViewDelegate {
    func didPressButton() {
        do {
            if !dataPersistence.hasItemBeenSaved(book) {
                try dataPersistence.createItem(book)
            } else {
                // TODO: Present an error controller
                print("Item has already been saved.")
            }
        } catch {
            print(error)
        }
    }
}
