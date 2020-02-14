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

// MARK: - ListType
struct ListWrapper: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let lastModified: String
    let list: List

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case numResults = "num_results"
        case lastModified = "last_modified"
        case list = "results"
    }
}

// MARK: - Results
struct List: Codable {
    let listName: String
    let listNameEncoded: String
    let bestsellersDate: String
    let publishedDate: String
    let publishedDateDescription: String
    let nextPublishedDate: String
    let previousPublishedDate: String
    let displayName: String
    let normalListEndsAt: Int
    let updated: String
    let books: [Book]

    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case listNameEncoded = "list_name_encoded"
        case bestsellersDate = "bestsellers_date"
        case publishedDate = "published_date"
        case publishedDateDescription = "published_date_description"
        case nextPublishedDate = "next_published_date"
        case previousPublishedDate = "previous_published_date"
        case displayName = "display_name"
        case normalListEndsAt = "normal_list_ends_at"
        case updated = "updated"
        case books = "books"
    }
    
    static let categories = ["Combined Print and E-Book Fiction", "Combined Print and E-Book Nonfiction", "Hardcover Fiction", "Hardcover Nonfiction", "Trade Fiction Paperback", "Mass Market Paperback", "Paperback Nonfiction", "E-Book Fiction", "E-Book Nonfiction", "Hardcover Advice", "Paperback Advice", "Advice How-To and Miscellaneous", "Hardcover Graphic Books", "Paperback Graphic Books", "Manga", "Combined Print Fiction", "Combined Print Nonfiction", "Chapter Books", "Childrens Middle Grade", "Childrens Middle Grade E-Book", "Childrens Middle Grade Hardcover", "Childrens Middle Grade Paperback", "Paperback Books", "Picture Books", "Series Books", "Young Adult", "Young Adult E-Book", "Young Adult Hardcover", "Young Adult Paperback", "Animals", "Audio Fiction", "Audio Nonfiction", "Business Books", "Celebrities", "Crime and Punishment", "Culture", "Education", "Espionage", "Expeditions Disasters and Adventures", "Fashion Manners and Customs", "Food and Fitness", "Games and Activities", "Graphic Books and Manga", "Hardcover Business Books", "Health", "Humor", "Indigenous Americans", "Relationships", "Mass Market Monthly", "Middle Grade Paperback Monthly", "Paperback Business Books", "Family", "Hardcover Political Books", "Race and Civil Rights", "Religion Spirituality and Faith", "Science", "Sports", "Travel", "Young Adult Paperback Monthly"]
    
    static var encodedCategories: [String] {
        categories.map { $0.lowercased().replacingOccurrences(of: " ", with: "-")}
    }
}

// MARK: - Book
struct Book: Codable, Equatable {
    let rank: Int
    let rankLastWeek: Int
    let weeksOnList: Int
    let asterisk: Int
    let dagger: Int
    let primaryIsbn10: String
    let primaryIsbn13: String
    let publisher: String
    let bookDescription: String
    let price: Int
    let title: String
    let author: String
    let contributor: String
    let contributorNote: String
    let bookImage: String
    let bookImageWidth: Int
    let bookImageHeight: Int
    let amazonProductURL: String
    let ageGroup: String
    let bookReviewLink: String
    let firstChapterLink: String
    let sundayReviewLink: String
    let articleChapterLink: String
    let isbns: [Isbn]
    let buyLinks: [BuyLink]
    let bookURI: String

    enum CodingKeys: String, CodingKey {
        case rank = "rank"
        case rankLastWeek = "rank_last_week"
        case weeksOnList = "weeks_on_list"
        case asterisk = "asterisk"
        case dagger = "dagger"
        case primaryIsbn10 = "primary_isbn10"
        case primaryIsbn13 = "primary_isbn13"
        case publisher = "publisher"
        case bookDescription = "description"
        case price = "price"
        case title = "title"
        case author = "author"
        case contributor = "contributor"
        case contributorNote = "contributor_note"
        case bookImage = "book_image"
        case bookImageWidth = "book_image_width"
        case bookImageHeight = "book_image_height"
        case amazonProductURL = "amazon_product_url"
        case ageGroup = "age_group"
        case bookReviewLink = "book_review_link"
        case firstChapterLink = "first_chapter_link"
        case sundayReviewLink = "sunday_review_link"
        case articleChapterLink = "article_chapter_link"
        case isbns = "isbns"
        case buyLinks = "buy_links"
        case bookURI = "book_uri"
    }
}

// MARK: - BuyLink
struct BuyLink: Codable, Equatable {
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}

// MARK: - Isbn
struct Isbn: Codable, Equatable {
    let isbn10: String
    let isbn13: String

    enum CodingKeys: String, CodingKey {
        case isbn10 = "isbn10"
        case isbn13 = "isbn13"
    }
}

