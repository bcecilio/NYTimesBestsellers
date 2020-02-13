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
        return label
    }()
    
    public var bookDescriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Length book was on Best Sellers List"
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
    }
    
    private func setupImageView() {
        
    }
}
