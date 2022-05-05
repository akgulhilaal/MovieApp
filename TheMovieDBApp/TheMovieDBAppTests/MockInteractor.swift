//
//  MockInteractor.swift
//  TheMovieDBAppTests
//
//  Created by Hilal Akgül on 3.05.2022.
//

import Foundation
@testable import TheMovieDBApp

final class MockInteractor: HomeInteractorProtocol {
    
    var invokedFetchMovie = false
    var invokedFetchMovieCount = 0
    
    func fetchUpComingMovies() {
        self.invokedFetchMovie = true
        self.invokedFetchMovieCount += 1
    }
    
    func fetchNowPlayingMovies() {
        self.invokedFetchMovie = true
        self.invokedFetchMovieCount += 1
    }
    
    
}
