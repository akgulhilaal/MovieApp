//
//  SearchingMovieResponse.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 1.05.2022.
//

import Foundation

import Foundation

// MARK: - NowPlaying
struct MovieSearchResponse: Codable {
    let page: Int?
    let results: [SearchResults]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SearchResults: Codable {
    let posterPath, overview, releaseDate, originalTitle,title, backdropPath: String?
    let adult,video: Bool?
    let genreIDS: [Int]?
    let id,voteCount: Int
    let popularity, voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}
