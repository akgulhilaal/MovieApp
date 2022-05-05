//
//  UpComingCellPresenter.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 29.04.2022.
//

import Foundation

protocol UpComingCellPresenterProtocol: AnyObject {
    func load()
}

final class UpComingCellPresenter {
    
    weak var view: UpComingCellProtocol?
    private let source: MovieResult
    
    init(view: UpComingCellProtocol?, source: MovieResult) {
        self.view = view
        self.source = source
    }
    
}

extension UpComingCellPresenter: UpComingCellPresenterProtocol {
    
    func load() {
        view?.setTitleLabel(source.title ?? "bol")
        view?.setMovieImageView(Constants.baseLowResImageURL + source.posterPath!)

    }
    
}
