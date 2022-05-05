//
//  HomeInteractor.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 24.04.2022.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func fetchUpComingMovies()
    func fetchNowPlayingMovies()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func fetchUpComingMoviesOutput(result: UpComingMoviesResult)
    func fetchNowPlayingMoviesOutput(result: NowPlayingMovieResult)
}
typealias UpComingMoviesResult = Result<MovieUpcomingResponse, Error>
typealias NowPlayingMovieResult = Result<MovieNowPlayingResponse, Error>
fileprivate var movieService: MoviesServiceProtocol = MoviesService()

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    func fetchUpComingMovies() {
        movieService.fetchUpcomingMovies{ [weak self] result in
            guard let self = self else { return }
            self.output?.fetchUpComingMoviesOutput(result: result)
        }
    }
    
    
    func fetchNowPlayingMovies() {
        movieService.fetchNowPlayingMovies { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchNowPlayingMoviesOutput(result: result)
        }
    }
    
    
}
