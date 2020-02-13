//
//  NYTList.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/13/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation

struct ListTypeWrapper: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [ListType]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case numResults = "num_results"
        case results = "results"
    }
}

// MARK: - ListType
struct ListType: Codable {
    let listName: String
    let displayName: String
    let listNameEncoded: String
    let oldestPublishedDate: String
    let newestPublishedDate: String
    let updated: String

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case listNameEncoded = "list_name_encoded"
        case oldestPublishedDate = "oldest_published_date"
        case newestPublishedDate = "newest_published_date"
        case updated = "updated"
    }
}
