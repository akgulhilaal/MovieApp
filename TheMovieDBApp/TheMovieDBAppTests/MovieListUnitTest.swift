//
//  MovieListUnitTest.swift
//  TheMovieDBAppTests
//
//  Created by Hilal Akgül on 3.05.2022.
//

import XCTest
@testable import TheMovieDBApp

class MovieListUnitTest: XCTestCase {
    
    var mock: BaseMock?
    let bundle = Bundle(for: MovieListUnitTest.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidParse() {
        mock = BaseMock(file: "movie_list", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let movies = try JSONDecoder().decode(MovieNowPlayingResponse.self, from: jsonData)
            
            XCTAssertEqual(movies.totalResults!, 1390)
            XCTAssertEqual(movies.totalPages!, 70)
            XCTAssertEqual(movies.page!, 1)
            XCTAssert((movies.results?.count ?? 0) > 0)
            
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseEmpty() {
        mock = BaseMock(file: "error", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            XCTAssertThrowsError(try JSONDecoder().decode(MovieNowPlayingResponse.self, from: jsonData))
        } catch { }
    }
    func testMovieDetails_response_with_movieID() throws {
            let expectation = self.expectation(description: "API should get response and runs the callback closure")
            
            let testableAPI = "https://api.themoviedb.org/3/movie/now_playing?api_key=0c195f58ca8d987be1e5cb4d52f05595"
            guard let url = URL(string:testableAPI) else { return }


            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                // Then
                XCTAssertNil(error)
                XCTAssertNotNil(data, "We got movie details data in the response")
                XCTAssertNotNil(response)
                
                expectation.fulfill()
            }
            task.resume()
        waitForExpectations(timeout: 10) { error in
                if let error = error {
                    XCTFail("waitForExpectationsWithTimeout errored: \(error)")
                }
            }
        }
}

