//
//  MovieDetail.swift
//  Movies
//
//  Created by Valerii D on 21.09.2021.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Decodable {
    let genres: [Genre]
    let revenue, runtime: Int
    let status: String
}

// MARK: - Genre
struct Genre: Codable {
    let name: String?
}




