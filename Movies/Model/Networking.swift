//
//  Networking.swift
//  Movies
//
//  Created by Valerii D on 19.09.2021.
//

import Foundation

// MARK: - Protocols
protocol NetworkingProtocol {
    func fetchPopular(_ completion: @escaping (Popular) -> Void)
    func fetchMovieDetail(id: Int, _ completion: @escaping (MovieDetail) -> Void)
    func fetchTrailer(id: Int, _ completion: @escaping (Trailer) -> Void)
}

// MARK: - Url

enum Url {
    static let urlDetail: String = "https://api.themoviedb.org/3/movie/"
    static let apiKey: String = "api_key=60f7f0bece03e78f837cf689be13d68f"
    static let urlPoster: String = "https://image.tmdb.org/t/p/w500"
    static let urlYoutube: String = "https://www.youtube.com/watch?v="
    static let popular: String = "popular?"
    static let videos: String = "/videos?"
}

// MARK: - Networking

class Networking: NetworkingProtocol {
    
    // MARK: - Static properties
    
 static let shared = Networking()
    
    // MARK: - Public methods
    
    func fetchPopular(_ completion: @escaping (Popular) -> Void) {
        fetchData(urlString: "\(Url.urlDetail)\(Url.popular)\(Url.apiKey)", completion)
    }
    
    func fetchMovieDetail(id: Int, _ completion: @escaping (MovieDetail) -> Void) {
        fetchData(urlString: "\(Url.urlDetail)\(id)?\(Url.apiKey)", completion)
    }
    
    func fetchTrailer(id: Int, _ completion: @escaping (Trailer) -> Void) {
        fetchData(urlString: "\(Url.urlDetail)\(id)\(Url.videos)\(Url.apiKey)", completion)
    }
      
    // MARK: - Private methods

    private func fetchData<T: Decodable>(urlString: String, _ completion: @escaping (T) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result)
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    private init() {}
}
