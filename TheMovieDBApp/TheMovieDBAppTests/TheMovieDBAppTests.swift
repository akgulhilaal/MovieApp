//
//  TheMovieDBAppTests.swift
//  TheMovieDBAppTests
//
//  Created by Hilal Akgül on 24.04.2022.
//

import XCTest
@testable import TheMovieDBApp

class TheMovieDBAppTests: XCTestCase {
    
    var presenter: HomePresenter!
    var view: MockViewControllerUnitTest!
    var interactor: MockInteractor!
    var router : MockRouter!
    var detailVC : MovieDetailViewController!
    var searchVC = SearchViewController()
    let describedClass = Router.nowPlaying
    let webservice = MoviesService()


    override func setUpWithError() throws {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)   }

    override func tearDownWithError() throws {
        view = nil
        interactor = nil
        router = nil
        presenter = nil
        
    }

    func testTheMovieDatabaseAPIAddress() {
        XCTAssertEqual("https://api.themoviedb.org/3/", describedClass.baseURL.cacheKey)
    }
    
    func testInitialisation() {
        XCTAssertNotNil(view, "ViewController could not be loaded")
    }
    
    func test_viewWillAppear_InvokesRequiredViewMethods() {
        XCTAssertFalse(view.isInvokedShowCV, "Value should be false")
        XCTAssertFalse(view.isInvokedHideCV, "Value should be false")
        presenter.viewDidLoad()
        
    }
    func testPresenterRoute() {
        XCTAssertNotNil(presenter.router, "presenter does not routes")

    }
    
    func testTableViewProtocolsConformance()
        {
        XCTAssertNotNil(presenter.source(_:) , "number of data is 0" )
        XCTAssertNotNil(presenter.numberOfItems() , "number of data is 0" )
        }

    func testCollectionViewProtocolsConformance()
        {
            let detail_VC = MovieDetailViewController()
            XCTAssertTrue(detail_VC.conforms(to: UICollectionViewDelegate.self), "does not conforms to UICollectionViewDelegate")
            XCTAssertTrue(detail_VC.conforms(to: UICollectionViewDataSource.self), "does not conforms to UICollectionViewDataSource")
        }
    
    func test_webService() {
        webservice.fetchSimilarMovies(movieId: 767825){ (result) in
               switch result {
               case .success(_):
                   XCTAssertTrue(true, "List fetched")
               case .failure(_):
                   XCTAssertFalse(false, "list fetch failed")
               }
           }
       }


}
