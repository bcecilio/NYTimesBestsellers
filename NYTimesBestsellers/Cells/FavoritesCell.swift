//
//  FavoritesCell.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import ImageKit

protocol FavoritesCellDelegate: AnyObject {
    func moreButtonPressed(_ favoritesCell: FavoritesCell, book: Book)
}

class FavoritesCell: UICollectionViewCell {
    
    weak var delegate: FavoritesCellDelegate?
    
    var currentBook: Book!
    
    public lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "Text View text goes here"
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    public lazy var weeksLabel: UILabel = {
        let label = UILabel()
        label.text = "Number of weeks in Best Sellers list"
        return label
    }()
    
    public lazy var moreButton: UIButton = {
       let button = UIButton()
       button.setBackgroundImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
       return button
    }()
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "book")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    @objc func buttonPressed() {
        delegate?.moreButtonPressed(self, book: currentBook)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        configureButton()
        configureImageView()
        configureLabel()
        configureTextView()
    }
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func configureButton() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            moreButton.heightAnchor.constraint(equalToConstant: 35),
            moreButton.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func configureLabel() {
        addSubview(weeksLabel)
        weeksLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weeksLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            weeksLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    private func configureTextView() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: weeksLabel.bottomAnchor, constant: 12),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    public func configure(for book: Book) {
        currentBook = book
        weeksLabel.text = "\(book.weeksOnList.description) weeks in best sellers list"
        textView.text = book.bookDescription
        imageView.getImage(with: book.bookImage) { (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
}

