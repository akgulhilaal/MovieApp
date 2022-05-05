//
//  SimilarMoviesPresenter.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 29.04.2022.
//

import Foundation

protocol SimilarCellPresenterProtocol: AnyObject {
    func load()
}

final class SimilarMoviesPresenter {
    
    weak var view: SimilarCellProtocol?
    private let source: SimilarMoviesResult
    
    init(view: SimilarCellProtocol?, source: SimilarMoviesResult) {
        self.view = view
        self.source = source
    }
}

extension SimilarMoviesPresenter: SimilarCellPresenterProtocol {
    
    func load() {
        view?.setDetailImageView(Constants.baseLowResImageURL + source.backdropPath!)
        view?.setTitleLabel(source.title)
    }
    
}
