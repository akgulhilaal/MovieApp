//
//  SearchUnitTest.swift
//  TheMovieDBAppTests
//
//  Created by Hilal Akgül on 3.05.2022.
//

import XCTest
@testable import TheMovieDBApp

final class SearchUnitTest : XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSearchDecoding() throws {
        let testableAPI = "https://api.themoviedb.org/3/search/movie?api_key=0c195f58ca8d987be1e5cb4d52f05595&query=The"
        let jsonData = try Data(contentsOf: URL(string: testableAPI)!)
        XCTAssertNoThrow(try JSONDecoder().decode(MovieSearchResponse.self, from: jsonData))
    }
}
