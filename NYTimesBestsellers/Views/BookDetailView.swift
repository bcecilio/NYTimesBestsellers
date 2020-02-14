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
    
    public weak var delegate: BookDetailViewDelegate?
    
    @objc private func buttonPressed(_ sender: UIButton) {
        /// Add this action to a button that saves the book in detail.
        delegate?.didPressButton()
    }

}
