//
//  NYTBook.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation

// MARK: - ListType
struct BookDetailWrapper: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [BookDetail]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case numResults = "num_results"
        case results = "results"
    }
}

// MARK: - Result
struct BookDetail: Codable {
    let url: String
    let publicationDt: String
    let byline: String
    let bookTitle: String
    let bookAuthor: String
    let summary: String
    let uuid: String
    let uri: String
    let isbn13: [String]

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case publicationDt = "publication_dt"
        case byline = "byline"
        case bookTitle = "book_title"
        case bookAuthor = "book_author"
        case summary = "summary"
        case uuid = "uuid"
        case uri = "uri"
        case isbn13 = "isbn13"
    }
}
