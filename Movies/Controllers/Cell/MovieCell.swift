//
//  MovieCell.swift
//  Movies
//
//  Created by Valerii D on 20.09.2021.
//

import UIKit
import SDWebImage

// MARK: - MovieCell

class MovieCell: UITableViewCell {

    // MARK: - Static properties
    
    private static let formatter = DateFormatter()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    // MARK: - Public methods
    
    func configure(_ movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text = convertDate(from: movie.releaseDate)
        languageLabel.text = movie.originalLanguage == "en" ? "🇺🇸" : "🇪🇸"
        ratingLabel.text = "⭐️ \(movie.voteAverage)"
        
        guard let imageUrl = URL(string: Url.urlPoster + movie.posterPath ) else { return }
        posterImage.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Movies"))
    }
    
    // MARK: - Private methods
    
    private func convertDate(from string: String?) -> String {
        MovieCell.formatter.dateFormat = "yyyy-MM-dd"
        if let releaseDate = MovieCell.formatter.date(from: string ?? "") {
            MovieCell.formatter.dateFormat = "MMM d, yyyy"
            return MovieCell.formatter.string(from: releaseDate)
        }
        return ""
    }
}
