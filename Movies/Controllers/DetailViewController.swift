//
//  ViewController.swift
//  Movies
//
//  Created by Valerii D on 18.09.2021.
//

import UIKit
import SDWebImage

// MARK: - DetailViewController

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var tralerButton: UIButton!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    
    // MARK: - Public properties
    
    var movie: Movie?
    
    // MARK: - Private properties
    
    private var networking: NetworkingProtocol = Networking.shared
    
    // MARK: - Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tralerButton.layer.cornerRadius = 10
        
        if let movie = movie {
            configure(from: movie)
            configureDetail(from: movie)
        }
    }

    // MARK: - Private methods
    
    private func configure(from movie: Movie) {
        titleLabel.text = movie.title
        overviewTextView.text = movie.overview
        ratingLabel.text = "⭐️ \(movie.voteAverage)"
    
        guard let imageUrl = URL(string: Url.urlPoster + movie.backdropPath) else { return }
        posterImage.sd_setImage(with: imageUrl, placeholderImage: #imageLiteral(resourceName: "Movies"))
    }
    
    private func configureDetail(from movie: Movie) {
        networking.fetchMovieDetail(id: movie.id) { movieDetail in
            DispatchQueue.main.async { [weak self] in
                self?.runtimeLabel.text = "🕒 \(movieDetail.runtime) min"
                self?.genresLabel.text = movieDetail.genres.first?.name
                if movieDetail.revenue != 0 {
                    self?.revenueLabel.text = "Revenue 💲 \(movieDetail.revenue / 1000000) million"
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let trailerVC = segue.destination as? TrailerViewController {
            trailerVC.id = movie?.id
        }
    }
}
