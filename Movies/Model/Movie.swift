//
//  Movie.swift
//  Movies
//
//  Created by Valerii D on 19.09.2021.
//

import Foundation

// MARK: - Result
struct Result: Decodable {
    let results: [Movie]
}

// MARK: - Movie
struct Movie: Decodable {
    let backdropPath: String
    let id: Int
    let originalLanguage: String
    let overview: String
    let posterPath, releaseDate, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
