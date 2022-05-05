//
//  ServiceManager.swift
//  TheMovieDBApp
//  Created by Hilal Akgül on 24.04.2022.
//

import Foundation

protocol MoviesServiceProtocol {
    
    func fetchNowPlayingMovies(completionHandler: @escaping (NowPlayingMovieResult) -> ())
    func fetchUpcomingMovies(completionHandler: @escaping (UpComingMoviesResult) -> ())
    func fetchSearchResults(query:String?, completionHandler: @escaping (SearchResult) -> ())
    func fetchMovieDetail(movieId:Int?, completionHandler: @escaping (DetailsResult) -> ())
    func fetchSimilarMovies(movieId:Int?, completionHandler: @escaping (SimilarResult) -> ())
}

struct MoviesService: MoviesServiceProtocol {
    func fetchNowPlayingMovies(completionHandler: @escaping (NowPlayingMovieResult) -> ()) {
        NetworkManager.shared.request(Router.nowPlaying, decodeToType: MovieNowPlayingResponse.self, completionHandler: completionHandler)
    }
    
    func fetchUpcomingMovies(completionHandler: @escaping (UpComingMoviesResult) -> ()) {
        NetworkManager.shared.request(Router.upcoming, decodeToType: MovieUpcomingResponse.self, completionHandler: completionHandler)
    }
    
    func fetchSearchResults(query: String?, completionHandler: @escaping (SearchResult) -> ()) {
        NetworkManager.shared.request(Router.search(query: query), decodeToType: MovieSearchResponse.self, completionHandler: completionHandler)
    }
    
    func fetchMovieDetail(movieId: Int?, completionHandler: @escaping (DetailsResult) -> ()) {
        NetworkManager.shared.request(Router.detail(movieId: movieId), decodeToType: MovieDetailResponse.self, completionHandler: completionHandler)
    }
    
    func fetchSimilarMovies(movieId: Int?, completionHandler: @escaping (SimilarResult) -> ()) {
        NetworkManager.shared.request(Router.similar(movieId: movieId), decodeToType: SimilarMovies.self, completionHandler: completionHandler)
    }
    
    
    
    
}

