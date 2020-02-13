//
//  BestsellerCell.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

class BestsellerCell: UICollectionViewCell {
    
    public var bookImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "book")
        return image
    }()
    
    public var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Length book was on Best Sellers List"
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        return label
    }()
    
    public var bookDescriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.font = UIFont(name: "HelveticaNeue-Light", size: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupImageView()
        setupTitleLabel()
        setupDescription()
    }
    
    private func setupImageView() {
        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: topAnchor),
            bookImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bookImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bookImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupDescription() {
        addSubview(bookDescriptionLabel)
        bookDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookDescriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bookDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bookDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            bookDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
