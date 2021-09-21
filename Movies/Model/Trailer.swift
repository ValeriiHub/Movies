//
//  Trailer.swift
//  Movies
//
//  Created by Valerii D on 20.09.2021.
//

import Foundation

struct Trailer: Decodable {
    let results: [ResultKey]
}

struct ResultKey: Decodable {
    let key: String?
}
