//
//  MovieDetailRouter.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 29.04.2022.
//

import Foundation

protocol MovieDetailRouterProtocol: AnyObject {
    func navigate(_ route: DetailRoutes)
}

enum DetailRoutes {
    case detail(source: Int)
}
final class MovieDetailRouter {
    
    weak var viewController: MovieDetailViewController?
    
    static func createModule() -> MovieDetailViewController {
        let view = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }

}
extension MovieDetailRouter : MovieDetailRouterProtocol{
    func navigate(_ route: DetailRoutes) {
        switch route {
        case .detail(let source):
            let detailVC = MovieDetailRouter.createModule()
            detailVC.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)

        }
    }
    
    
}
