//
//  MovieDetailInteractor.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 29.04.2022.
//

import Foundation

protocol MovieDetailInteractorProtocol: AnyObject {
    func fetchDetails(with id : Int)
    func fetchSimilar(with id : Int)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func fetchDetailsOutput(result: DetailsResult)
    func fetchSimilarOutput(result: SimilarResult)
}

typealias DetailsResult = Result<MovieDetailResponse, Error>
typealias SimilarResult = Result<SimilarMovies, Error>

fileprivate var movieService: MoviesServiceProtocol = MoviesService()

final class MovieDetailInteractor{
    var output: MovieDetailInteractorOutputProtocol?
}
extension MovieDetailInteractor : MovieDetailInteractorProtocol{
    
    func fetchSimilar(with id: Int) {
        movieService.fetchSimilarMovies(movieId : id) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSimilarOutput(result: result)

        }
    }
    
    func fetchDetails(with id: Int) {
        movieService.fetchMovieDetail(movieId : id) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchDetailsOutput(result: result)
        }

    }
    
  
}
