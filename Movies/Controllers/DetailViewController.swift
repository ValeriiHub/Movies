//
//  ViewController.swift
//  Movies
//
//  Created by Valerii D on 18.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var tralerButton: UIButton!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    
    var movie: Movie?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tralerButton.layer.cornerRadius = 10
        
        if let movie = movie {
            configure(from: movie)
            configureDetail(from: movie)
        }
    }

    private func configure(from movie: Movie) {
        titleLabel.text = movie.title
        overviewTextView.text = movie.overview
        ratingLabel.text = "⭐️ \(movie.voteAverage)"
    
        guard let imageUrl = URL(string: Url.urlPoster + movie.backdropPath) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self?.posterImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func configureDetail(from movie: Movie) { 
        Networking.shared.fetchMovieDetail(id: movie.id) { movieDetail in
            DispatchQueue.main.async { [weak self] in
                self?.runtimeLabel.text = "🕒 \(movieDetail.runtime) min"
                self?.genresLabel.text = movieDetail.genres.first?.name
                if movieDetail.revenue != 0 {
                    self?.revenueLabel.text = "Revenue 💲 \(movieDetail.revenue / 1000000) million"
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let trailerVC = segue.destination as? TrailerViewController {
            trailerVC.id = movie?.id
        }
    }
}

