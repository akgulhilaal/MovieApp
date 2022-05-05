//
//  HomeRouter.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 24.04.2022.
//

import Foundation

protocol HomeRouterProtocol: AnyObject {
    func navigate(_ route: HomeRoutes)
}

enum HomeRoutes {
    case detail(source: Int)
    case searching
}

final class HomeRouter {
    
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension HomeRouter: HomeRouterProtocol {
    
    func navigate(_ route: HomeRoutes) {
        switch route {
        case .detail(let source):
            let detailVC = MovieDetailRouter.createModule()
            detailVC.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        case .searching:
            let searchResultVC = SearchRouter.createModule()
            self.viewController?.setSearchController(vc: searchResultVC)
    
        }
    }
    
}

