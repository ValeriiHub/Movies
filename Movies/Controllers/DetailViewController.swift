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

    func configure(from movie: Movie) {
        titleLabel.text = movie.title
        overviewTextView.text = movie.overview
        ratingLabel.text = "⭐️ \(movie.voteAverage ?? 0)"
    
        guard let urlString = movie.backdropPath else { return }
        guard let imageUrl = URL(string: posterUrl + urlString ) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: imageData)
            }
        }
    }
    
    func configureDetail(from movie: Movie) {
        if let id = movie.id {
            let url = "\(Url.urlDetail)\(id)?\(Url.apiKey)"
            Networking.shared.fetchData(urlString: url) { (movieDetail: MovieDetail) in
                DispatchQueue.main.async {
                    self.runtimeLabel.text = "🕒 \(movieDetail.runtime ?? 0) min"
                    self.genresLabel.text = movieDetail.genres.first?.name
                    if let revenue = movieDetail.revenue, revenue != 0 {
                        self.revenueLabel.text = "Revenue 💲 \(revenue / 1000000) million"
                    }
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

