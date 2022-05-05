//
//  FavoriteMovies.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 30.04.2022.
//

import Foundation

struct FavoriteMovies {
    
    static var shared = FavoriteMovies()
    static let FavoriteMoviesKey = "FavoriteMovies"
    
    func setFavoriteMovie(_ movieId: Int) {
        var currentFavoriteMovies = load()
        
        if isFavorite(movieId) {
            if let index = currentFavoriteMovies.firstIndex(of: movieId) {
                currentFavoriteMovies.remove(at: index)
            }
        } else {
            currentFavoriteMovies.append(movieId)
        }
        UserDefaults.standard.set(currentFavoriteMovies, forKey: FavoriteMovies.FavoriteMoviesKey)
    }
    
    func load() -> [Int] {
        return UserDefaults.standard.array(forKey: FavoriteMovies.FavoriteMoviesKey)  as? [Int] ?? [Int]()
    }
    
    func isFavorite(_ movieId: Int) -> Bool{
        let currentFavoriteMovies = load()
        
        if currentFavoriteMovies.contains(where: {$0 == movieId}) {
            return true
        }
        
        return false
    }
}
