//
//  Trailer.swift
//  Movies
//
//  Created by Valerii D on 20.09.2021.
//

import Foundation

// MARK: - Trailer
struct Trailer: Decodable {
    let results: [ResultKey]
}

// MARK: - ResultKey
struct ResultKey: Decodable {
    let key: String?
}
