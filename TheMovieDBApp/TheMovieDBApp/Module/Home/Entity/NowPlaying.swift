//
//  NowPlaying.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 27.04.2022.
//

import Foundation

// MARK: - NowPlaying
struct MovieNowPlayingResponse: Codable {
    let page: Int?
    let results: [Results]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result
struct Results: Codable {
    let originalTitle: String
    let posterPath,overview, releaseDate,title, backdropPath: String?
    let adult,video: Bool?
    let genreIDS: [Int]?
    let id,voteCount: Int?
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
