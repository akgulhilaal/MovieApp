//
//  UpComing.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 24.04.2022.
//

import Foundation

// MARK: - MoviesUpComing
struct MovieUpcomingResponse: Codable {
    let results: [MovieResult]?
    let totalPages, totalResults, page: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


// MARK: - Result
struct MovieResult: Codable {
    let posterPath: String?
    let adult: Bool?
    let overview, releaseDate: String?
    let genreIDS: [Int]?
    let id: Int
    let originalTitle, originalLanguage, title: String?
    let backdropPath: String?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult, overview
        case releaseDate = "release_date"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
}
