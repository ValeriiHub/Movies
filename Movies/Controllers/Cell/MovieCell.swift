//
//  MovieCell.swift
//  Movies
//
//  Created by Valerii D on 20.09.2021.
//

import UIKit

class MovieCell: UITableViewCell {

    private static let formatter = DateFormatter()
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configure(_ movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text = convertDate(from: movie.releaseDate)
        languageLabel.text = movie.originalLanguage == "en" ? "🇺🇸" : "🇪🇸"
        ratingLabel.text = "⭐️ \(movie.voteAverage)"
        
        guard let imageUrl = URL(string: Url.urlPoster + movie.posterPath ) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async { [weak self] in
                self?.posterImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func convertDate(from string: String?) -> String {
        MovieCell.formatter.dateFormat = "yyyy-MM-dd"
        if let releaseDate = MovieCell.formatter.date(from: string ?? "") {
            MovieCell.formatter.dateFormat = "MMM d, yyyy"
            return MovieCell.formatter.string(from: releaseDate)
        }
        return ""
    }
}
