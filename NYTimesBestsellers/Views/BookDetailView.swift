//
//  BookDetailView.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit
import ImageKit

protocol BookDetailViewDelegate: AnyObject {
    func didPressButton(_ button: UIButton)
}

class BookDetailView: UIView {
    
    private lazy var amazonButton: UIButton = {
        //TODO: Create photo.
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Amazon_icon.png"), for: .normal)
        button.tag = 0
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Books_(iOS).png"), for: .normal)
        button.tag = 1
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.black.cgColor
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.layer.cornerRadius = 3
        textView.clipsToBounds = true
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .secondarySystemBackground
        configureAmazonButton()
        configureAppleButton()
        configureImageView()
        configureTitleLabel()
        configureTextView()
    }
    
    public weak var delegate: BookDetailViewDelegate?
    
    @objc private func buttonPressed(_ sender: UIButton) {
        /// Add this action to a button that saves the book in detail.
        delegate?.didPressButton(sender)
    }
    
    public func configureView(_ book: Book) {
        titleLabel.text = book.title
        textView.text = book.bookDescription
        imageView.getImage(with: book.bookImage, writeTo: .cachesDirectory) { result in
            switch result {
            case .failure:
                break
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        
    }
    
    public func configureText(_ str: String) {
        textView.text = str
    }
    
    private func configureAmazonButton() {
        addSubview(amazonButton)
        amazonButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            amazonButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 8),
            amazonButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            amazonButton.heightAnchor.constraint(equalToConstant: 120),
            amazonButton.widthAnchor.constraint(equalTo: amazonButton.heightAnchor)
        ])
    }
    
    private func configureAppleButton() {
        addSubview(appleButton)
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleButton.topAnchor.constraint(equalTo: amazonButton.bottomAnchor, constant: 8),
            appleButton.centerXAnchor.constraint(equalTo: amazonButton.centerXAnchor, constant: 6.5),
            appleButton.heightAnchor.constraint(equalTo: amazonButton.heightAnchor),
            appleButton.widthAnchor.constraint(equalTo: amazonButton.widthAnchor)])
    }
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: amazonButton.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureTextView() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    
}
