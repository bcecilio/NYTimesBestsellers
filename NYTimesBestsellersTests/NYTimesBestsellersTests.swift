//
//  NYTimesBestsellersTests.swift
//  NYTimesBestsellersTests
//
//  Created by Brendon Cecilio on 2/5/20.
//  Copyright © 2020 Brendon Cecilio. All rights reserved.
//

import XCTest
@testable import NYTimesBestsellers

class NYTimesBestsellersTests: XCTestCase {
    
    func testGetLists() {
        let endpoint = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(NYTKey.key)"
        
        var listTypes = [ListType]()
        let exp = XCTestExpectation(description: "Created test for something")
        
        GenericCoderAPI.manager.getJSON(objectType: ListTypeWrapper.self, with: endpoint) { result in
            switch result {
            case .failure(let error):
                XCTFail("Failed to get JSON from link: \(error)")
            case .success(let wrapper):
                listTypes = wrapper.results
                XCTAssertEqual(listTypes.count, 59)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testBestSellersByList() {
        // 
        let listNameEncoded = "hardcover-fiction"
        let listnames = List.encodedCategories
        let endpoint = "https://api.nytimes.com/svc/books/v3/lists/current/\(listnames[0]).json?api-key=\(NYTKey.key)"
        var books = [Book]()
        let exp = XCTestExpectation(description: "Created test for something")
        
        GenericCoderAPI.manager.getJSON(objectType: ListWrapper.self, with: endpoint) { result in
            switch result {
            case .failure(let error):
                XCTFail("Failed to get JSON from link: \(error)")
            case .success(let wrapper):
                books = wrapper.list.books
                XCTAssertEqual(books.count, wrapper.numResults)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
    
    func testBestSellersByBook() {
        let primaryIsbn13 = "9781524763138"
        let endpoint = "https://api.nytimes.com/svc/books/v3/reviews.json?isbn=\(primaryIsbn13)&api-key=\(NYTKey.key)"
        
        var bookDetails = [BookDetail]()
        
        let exp = XCTestExpectation(description: "created test for something")
        
        GenericCoderAPI.manager.getJSON(objectType: BookDetailWrapper.self, with: endpoint) { result in
            switch result {
            case .failure(let error):
                XCTFail("Failed to get json: \(error)")
            case .success(let wrapper):
                bookDetails = wrapper.results
                XCTAssertEqual(bookDetails.count, wrapper.numResults)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
        
    }
    
    func testEquality() {
        let endpoint = "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=\(NYTKey.key)"
        
        var listTypes = [ListType]()
        let exp = XCTestExpectation(description: "Created test for something")
        
        GenericCoderAPI.manager.getJSON(objectType: ListTypeWrapper.self, with: endpoint) { result in
            switch result {
            case .failure(let error):
                XCTFail("Failed to get JSON from link: \(error)")
            case .success(let wrapper):
                listTypes = wrapper.results
                for index in 0..<listTypes.count {
                    XCTAssertEqual(listTypes[index].listNameEncoded, List.encodedCategories[index])
                }
                XCTAssertEqual(listTypes.count, 59)
                exp.fulfill()
            }
        }
        
        wait(for: [exp], timeout: 2)
    }
}
