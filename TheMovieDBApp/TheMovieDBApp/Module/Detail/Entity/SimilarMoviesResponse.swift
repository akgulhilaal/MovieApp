//
//  SimilarMoviesResponse.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 29.04.2022.
//

import Foundation

// MARK: - SimilarMovies
struct SimilarMovies: Codable {
    let page: Int
    let results: [SimilarMoviesResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarMoviesResult: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let title: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id, title
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
