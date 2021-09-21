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
    var trailerKey: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTrailerKey(from: id)
//        fetchTrailer(from: trailerKey)
    }
    
    func fetchTrailerKey(from id: Int?) {
        guard let id = id else { return }
        let url = "\(Url.urlDetail)\(id)\(Url.videos)\(Url.apiKey)"
        Networking.shared.fetchData(urlString: url) { (trailer: Trailer) in
            DispatchQueue.main.async {
//                self.trailerKey = trailer.results.first?.key
//                print(self.trailerKey)
                guard let trailerKey = trailer.results.first?.key else { return }
                guard let url = URL(string: Url.urlYoutube + trailerKey) else { return }
                let urlRequest = URLRequest(url: url)
                self.trailerWebView.load(urlRequest)
            }
        }
    }
    
//    func fetchTrailer(from trailerKey: String?) {
//        guard let trailerKey = trailerKey else {print("error 2"); return }
//        guard let url = URL(string: Url.urlYoutube + trailerKey) else {print("error 3"); return }
//        let urlRequest = URLRequest(url: url)
//        trailerWebView.load(urlRequest)
//    }
}
