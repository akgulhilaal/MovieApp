//
//  SearchInteractor.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 1.05.2022.
//

import Foundation

protocol SearchInteractorProtocol : AnyObject {
    func fetchSearch(with query : String)
}
protocol SearchInteractorOutputProtocol: AnyObject {
    func fetchSearchOutput(result: SearchResult)
}

typealias SearchResult = Result<MovieSearchResponse, Error>
fileprivate var movieService: MoviesServiceProtocol = MoviesService()


final class SearchInteractor {
    var output: SearchInteractorOutputProtocol?
}

extension SearchInteractor : SearchInteractorProtocol{

    func fetchSearch(with query: String) {
            movieService.fetchSearchResults(query : query) { [weak self] result in
                guard let self = self else { return }
                self.output?.fetchSearchOutput(result: result)

            }
        }
}

