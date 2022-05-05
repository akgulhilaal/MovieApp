//
//  MovieCellPresenter.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 28.04.2022.
//

import Foundation


protocol MovieCellPresenterProtocol: AnyObject {
    func load()
}

final class MovieCellPresenter {
    
    weak var view: MovieCellProtocol?
    private let source: Results
    
    init(view: MovieCellProtocol?, source: Results) {
        self.view = view
        self.source = source
    }
}

extension MovieCellPresenter: MovieCellPresenterProtocol {
    
    func load() {
        view?.setMovieImageView(Constants.baseLowResImageURL + source.backdropPath!)
        view?.setTitleLabel( "\(source.title!) (\(source.releaseDate!.convertYearFormat()))")
        view?.setDescrLabel(source.overview!)
    }
    
}
