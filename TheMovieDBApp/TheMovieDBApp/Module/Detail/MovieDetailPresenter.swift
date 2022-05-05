//
//  MovieDetailPresenter.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 29.04.2022.
//

import Foundation

protocol  MovieDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func load(source : MovieDetailResponse)
    func numberOfItems() -> Int
    func detailsSource(_ index: Int) -> SimilarMoviesResult?
    func didSelectRowAt(index: Int)
    func isFavorite(id : Int)

}


final class MovieDetailPresenter :MovieDetailPresenterProtocol{

    unowned var view: MovieDetailViewControllerProtocol?
    let router: MovieDetailRouterProtocol!
    let interactor: MovieDetailInteractorProtocol!
    
    private var sources : MovieDetailResponse!
    private var similarSources = [SimilarMoviesResult]()
    
    init(view: MovieDetailViewControllerProtocol, router: MovieDetailRouterProtocol, interactor: MovieDetailInteractorProtocol ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        fetchMovieDetails(with: view?.id() ?? 0 )
        fetchSimilarDetails(with: view?.id() ?? 0)
        view?.setupCollectionView()
    }
    

    private func fetchMovieDetails(with id: Int) {
        interactor.fetchDetails(with: id)

    }
    private func fetchSimilarDetails(with id: Int) {
        interactor.fetchSimilar(with: id)

    }
    func load(source: MovieDetailResponse) {
        view?.setmovieImage(Constants.baseLowResImageURL + sources.backdropPath ?? "no-pictures")
        view?.setmovieTitle(source.title)
        view?.setImdbUrl(Constants.imdbMoviePageURL + source.imdbID)
        view?.setmoviedateLabel((source.releaseDate?.convertDateFormat())!)
        view?.setmovieDescription(source.overview)
        view?.setmoviescoreLabel("⭐️\(source.voteAverage)")
    }
    
    
    func similarSources( index: Int) -> SimilarMoviesResult? {
            return similarSources[index]
        }

    func numberOfItems() -> Int {
        return similarSources.count
    }
    func detailsSource(_ index: Int) -> SimilarMoviesResult? {
        return similarSources[index]
    }
    func didSelectRowAt(index: Int) {
        var movieId:Int!
        guard let source = similarSources(index: index) else { return }
        movieId = source.id
        router.navigate(.detail(source: movieId))
    }
    func isFavorite(id: Int) {
        if FavoriteMovies.shared.isFavorite(id) == true{
            FavoriteMovies.shared.setFavoriteMovie(id)
            view?.setFavoriteButtonTitle("heart")
        }
        else{
            FavoriteMovies.shared.setFavoriteMovie(id)
            view?.setFavoriteButtonTitle("heart.fill")
        }
    }

    
}
extension MovieDetailPresenter : MovieDetailInteractorOutputProtocol{
    func fetchSimilarOutput(result: SimilarResult) {
        switch result {
            
        case .success(let sourcesResult ):
            similarSources = sourcesResult.results
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }

    func fetchDetailsOutput(result: DetailsResult) {
        switch result {
            
        case .success(let sourcesResult):
            sources = sourcesResult
            load(source: sources)
            view?.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
    
}
