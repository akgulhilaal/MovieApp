//
//  HomePresenter.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 24.04.2022.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func numberOfupComingItems() -> Int

    func source(_ index: Int) -> Results?
    func upComingSource(_ index: Int) -> MovieResult?
    func didSelectRowAt(index: Int , cell : String)
    
}

final class HomePresenter: HomePresenterProtocol {


    unowned var view: HomeViewControllerProtocol?
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    private var sources: [Results] = []
    private var upComingSources: [MovieResult] = []
    
    init(view: HomeViewControllerProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupCollectionView()
        view?.setTitle("Movies")
        fetchMovieResults()
        router.navigate(.searching)
    }
    
    func numberOfItems() -> Int {
        return sources.count
    }
    func numberOfupComingItems() -> Int {
        return upComingSources.count
    }
    
    func source(_ index: Int) -> Results? {
        return sources[index]
    }
    func upComingSource(_ index: Int) -> MovieResult? {
        return upComingSources[index]
    }

    
    func didSelectRowAt(index: Int , cell : String) {
        if cell == "upComingSource"{
            guard let source = upComingSource(index) else { return }
            router.navigate(.detail(source: source.id))
        }
        else {
            guard let source = source(index) else { return }
            router.navigate(.detail(source: source.id!))
        }
    }
    
    private func fetchMovieResults() {
        interactor.fetchNowPlayingMovies()
        interactor.fetchUpComingMovies()
    }
}

extension HomePresenter : HomeInteractorOutputProtocol {
    func fetchUpComingMoviesOutput(result: UpComingMoviesResult) {
        switch result {
            
        case .success(let sourcesResult):
            upComingSources = sourcesResult.results ?? []
            view?.reloadData()
            
        case .failure(let error):
            print(error)
        }
    
    }
    
    func fetchNowPlayingMoviesOutput(result: NowPlayingMovieResult) {
        switch result {
            
        case .success(let sourcesResult):
            sources = sourcesResult.results ?? []
            view?.setPageController(sources.count)
            view?.reloadData()
            
        case .failure(let error):
            print(error)
        }
    }
    
    
}

