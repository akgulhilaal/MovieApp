//
//  MockViewControllerUnitTest.swift
//  TheMovieDBAppTests
//
//  Created by Hilal Akgül on 3.05.2022.
//

import Foundation
@testable import TheMovieDBApp

final class MockViewControllerUnitTest: HomeViewControllerProtocol {
    func startTimer() {
         
    }
    
    var isInvokedShowCV = false
    var isInvokedHideCV = false
    var isInvokedShowSearch = false
    var isInvokedShowPC = false

       
    func reloadData() {
         
    }
    
    func setTitle(_ title: String) {
         
    }
    
    func setupCollectionView() {
        self.isInvokedShowCV = true
    }
    
    func setSearchController(vc: SearchViewController) {
        isInvokedShowSearch = true
    }
    
    func setPageController(_ pageNumber: Int) {
        isInvokedShowPC = true
    }
    
    
    
    
}
