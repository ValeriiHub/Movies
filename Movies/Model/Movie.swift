//
//  Movie.swift
//  Movies
//
//  Created by Valerii D on 19.09.2021.
//

import Foundation

// MARK: - Result
struct Result: Codable {
    let results: [Movie]
}

// MARK: - Movie
struct Movie: Codable {
    let backdropPath: String?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
