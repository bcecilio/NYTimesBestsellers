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
        let endpoint = "https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=\(NYTKey.key)"
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
}
