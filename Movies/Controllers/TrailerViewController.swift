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
    
    let networking = Networking()
    var id: Int?
    var str: URLRequest?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
