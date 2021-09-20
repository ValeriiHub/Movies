//
//  MovieCell.swift
//  Movies
//
//  Created by Valerii D on 20.09.2021.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configure(_ movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        languageLabel.text = movie.originalLanguage == "en" ? "🇺🇸" : "🇪🇸"
        ratingLabel.text = "⭐️ \(movie.voteAverage ?? 0)"
        
        DispatchQueue.global().async {
            guard let urlString = movie.posterPath else { return }
            guard let imageUrl = URL(string: posterUrl + urlString ) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: imageData)
            }
        }
    }

}
