//
//  SearchRouter.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 1.05.2022.
//

import Foundation


protocol SearchRouterProtocol: AnyObject {
    func navigate(_ route: SearchRoutes)
}

enum SearchRoutes {
    case detail(source: Int)
}

final class SearchRouter {
    
    weak var viewController: SearchViewController?
    
    static func createModule() -> SearchViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension SearchRouter: SearchRouterProtocol {
    
    func navigate(_ route: SearchRoutes) {
        switch route {
        case .detail(let source):
            let detailVC = MovieDetailRouter.createModule()
            detailVC.source = source
            viewController?.presentingViewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}
