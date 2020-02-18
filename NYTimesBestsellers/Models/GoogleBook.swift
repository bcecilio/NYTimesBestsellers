//
//  GoogleBook.swift
//  NYTimesBestsellers
//
//  Created by Brendon Cecilio on 2/18/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import Foundation


// MARK: - GoogleBook
struct GoogleBookWrapper: Codable {
    let kind: String
    let totalItems: Int
    let items: [GoogleBook]

    enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case totalItems = "totalItems"
        case items = "items"
    }
}

// MARK: - Item
struct GoogleBook: Codable {
    let kind: String
    let id: String
    let etag: String
    let selfLink: String
    let volumeInfo: VolumeInfo
    let searchInfo: SearchInfo

    enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case id = "id"
        case etag = "etag"
        case selfLink = "selfLink"
        case volumeInfo = "volumeInfo"
        case searchInfo = "searchInfo"
    }
}

// MARK: - SearchInfo
struct SearchInfo: Codable {
    let textSnippet: String

    enum CodingKeys: String, CodingKey {
        case textSnippet = "textSnippet"
    }
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String
    let subtitle: String
    let authors: [String]
    let publisher: String
    let publishedDate: String
    let description: String
    let pageCount: Int
    let printType: String
    let categories: [String]
    let averageRating: Double
    let ratingsCount: Int
    let maturityRating: String
    let allowAnonLogging: Bool
    let contentVersion: String
    let language: String
    let previewLink: String
    let infoLink: String
    let canonicalVolumeLink: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case subtitle = "subtitle"
        case authors = "authors"
        case publisher = "publisher"
        case publishedDate = "publishedDate"
        case description = "description"
        case pageCount = "pageCount"
        case printType = "printType"
        case categories = "categories"
        case averageRating = "averageRating"
        case ratingsCount = "ratingsCount"
        case maturityRating = "maturityRating"
        case allowAnonLogging = "allowAnonLogging"
        case contentVersion = "contentVersion"
        case language = "language"
        case previewLink = "previewLink"
        case infoLink = "infoLink"
        case canonicalVolumeLink = "canonicalVolumeLink"
    }
}

