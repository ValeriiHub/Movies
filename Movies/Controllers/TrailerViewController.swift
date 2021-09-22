//
//  TrailerViewController.swift
//  Movies
//
//  Created by Valerii D on 20.09.2021.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var trailerWebView: WKWebView!
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = id {
            fetchTrailerKey(from: id)
        }
    }
    
    private func fetchTrailerKey(from id: Int) {
        Networking.shared.fetchTrailer(id: id) { trailer in
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
