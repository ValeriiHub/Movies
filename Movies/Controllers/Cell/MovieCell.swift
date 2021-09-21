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
        releaseDateLabel.text = convertDate(from: movie.releaseDate)
        languageLabel.text = movie.originalLanguage == "en" ? "🇺🇸" : "🇪🇸"
        ratingLabel.text = "⭐️ \(movie.voteAverage ?? 0)"
        
        guard let urlString = movie.posterPath else { return }
        guard let imageUrl = URL(string: posterUrl + urlString ) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: imageData)
            }
        }
    }
    
    func convertDate(from string: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let releaseDate = dateFormatter.date(from: string ?? "") {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return dateFormatter.string(from: releaseDate)
        }
        return ""
    }
}
