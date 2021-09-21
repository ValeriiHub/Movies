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
    
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tralerButton.layer.cornerRadius = 10
        configure(movie!)
    }


    func configure(_ movie: Movie) {
        titleLabel.text = movie.title
        overviewTextView.text = movie.overview
    
        guard let urlString = movie.backdropPath else { return }
        guard let imageUrl = URL(string: posterUrl + urlString ) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: imageData)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let trailerVC = segue.destination as? TrailerViewController {
            trailerVC.id = movie?.id
        }
    }
}

