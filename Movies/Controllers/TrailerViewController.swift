//
//  TrailerViewController.swift
//  Movies
//
//  Created by Valerii D on 20.09.2021.
//

import UIKit
import WebKit

// MARK: - TrailerViewController

class TrailerViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var trailerWebView: WKWebView!
    
    // MARK: - Public properties
    
    var id: Int?
    
    // MARK: - Private properties
    
    private var networking: NetworkingProtocol = Networking.shared
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = id {
            fetchTrailerKey(from: id)
        }
    }
    
    // MARK: - Private methods
    
    private func fetchTrailerKey(from id: Int) {
        networking.fetchTrailer(id: id) { trailer in
            DispatchQueue.main.async { [weak self] in
                if let key = trailer.results.first?.key {
                    self?.fetchTrailer(from: key)
                }
                
            }
        }
    }
    
    private func fetchTrailer(from trailerKey: String) {
        guard let url = URL(string: Url.urlYoutube + trailerKey) else { return }
        let urlRequest = URLRequest(url: url)
        trailerWebView.load(urlRequest)
    }
}
