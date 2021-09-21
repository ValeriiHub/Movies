//
//  Networking.swift
//  Movies
//
//  Created by Valerii D on 19.09.2021.
//

import Foundation

enum Url {
    static let urlDetail: String = "https://api.themoviedb.org/3/movie/"
    static let apiKey: String = "api_key=799ad00db48f25949a3aaea920d756d6"
    static let urlPoster: String = "https://image.tmdb.org/t/p/w500"
    static let urlYoutube: String = "https://www.youtube.com/watch?v="
    static let popular: String = "popular?"
    static let videos: String = "/videos?"
}

class Networking {
    
 static var shared = Networking()

    func fetchData<T: Decodable>(urlString: String, _ completionHandler: @escaping (T) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(result)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
