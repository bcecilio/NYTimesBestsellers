//
//  BookDetailView.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import UIKit

protocol BookDetailViewDelegate: AnyObject {
    func didPressButton()
}

class BookDetailView: UIView {
    
    public lazy var amazonButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    public lazy var titleLabel: UILabel = {
      let label = UILabel()
      return label
    }()
    
    public lazy var textView: UITextView = {
        let textView = UITextView()
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
        configureButton()
        configureImageView()
        configureTitleLabel()
        configureTextView()
    }
    
    public weak var delegate: BookDetailViewDelegate?
    
    @objc private func buttonPressed(_ sender: UIButton) {
        /// Add this action to a button that saves the book in detail.
        delegate?.didPressButton()
    }
    
    private func configureButton() {
        addSubview(amazonButton)
        amazonButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            amazonButton.topAnchor.constraint(equalTo: topAnchor,constant: 8),
            amazonButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            amazonButton.heightAnchor.constraint(equalToConstant: 120),
            amazonButton.widthAnchor.constraint(equalTo: amazonButton.heightAnchor)
        ])
    }
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: amazonButton.frame.width + 12),
            imageView.trailingAnchor.constraint(equalTo: amazonButton.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
              titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
              titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
              titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func configureTextView() {
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
}
