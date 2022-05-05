//
//  SearchCellPresenter.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 1.05.2022.
//

import Foundation


protocol SearchCellPresenterProtocol: AnyObject {
    func load()
}

final class SearchCellPresenter {
    
    weak var view: SearchCellProtocol?
    private let source: SearchResults
    
    init(view: SearchCellProtocol?, source: SearchResults) {
        self.view = view
        self.source = source
    }
}

extension SearchCellPresenter: SearchCellPresenterProtocol {
    
    func load() {
        view?.setTitleLabel(source.title! )
        
    }
    
}
