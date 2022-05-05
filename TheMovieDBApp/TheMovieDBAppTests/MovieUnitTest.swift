//
//  MovieUnitTest.swift
//  TheMovieDBAppTests
//
//  Created by Hilal Akgül on 3.05.2022.
//

import XCTest
@testable import TheMovieDBApp

class MovieUnitTest: XCTestCase {

    var mock: BaseMock?
    let bundle = Bundle(for: MovieUnitTest.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidParse() {
        mock = BaseMock(file: "movie", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let movie = try JSONDecoder().decode(MovieDetailResponse.self, from: jsonData)
            
            XCTAssertEqual(movie.voteAverage, 7.0)
            XCTAssertEqual(movie.title, "The Outfit")
            XCTAssertEqual(movie.originalTitle, "The Outfit")
            XCTAssertEqual(movie.popularity, 2752.077)
            XCTAssertEqual(movie.backdropPath, "/2n95p9isIi1LYTscTcGytlI4zYd.jpg")
            XCTAssertEqual(movie.overview, "Leonard is an English tailor who used to craft suits on London’s world-famous Savile Row. After a personal tragedy, he’s ended up in Chicago, operating a small tailor shop in a rough part of town where he makes beautiful clothes for the only people around who can afford them: a family of vicious gangsters.")
            XCTAssertEqual(movie.releaseDate!, "2022-02-25")
            XCTAssertEqual(movie.runtime, 105)
            
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseEmpty() {
        mock = BaseMock(file: "error", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            XCTAssertThrowsError(try JSONDecoder().decode(MovieDetailResponse.self, from: jsonData))
        } catch { }
    }
    
    func testMovieDetails_response_with_movieID() throws {
            let expectation = self.expectation(description: "API should get response and runs the callback closure")
            
            let testableAPI = "https://api.themoviedb.org/3/movie/767825?api_key=0c195f58ca8d987be1e5cb4d52f05595&movieId=767825"
            guard let url = URL(string:testableAPI) else { return }


            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
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
