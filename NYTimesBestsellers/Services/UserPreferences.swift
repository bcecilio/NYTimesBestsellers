//
//  UserPreferences.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/13/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation

class UserPreferences {
    static let helper = UserPreferences()
    private let listingKey = "listing"
    private init () {}
    func store(listNum: Int) {
        UserDefaults.standard.set(listNum, forKey: listingKey)
    }
    func getListing() -> String? {
        UserDefaults.standard.string(forKey: listingKey)
    }
}
