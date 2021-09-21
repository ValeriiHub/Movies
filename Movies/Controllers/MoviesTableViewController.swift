//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by Valerii D on 19.09.2021.
//

import UIKit
let posterUrl = "https://image.tmdb.org/t/p/w500/"

class MoviesTableViewController: UITableViewController {
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.shared.fetchData(urlString: Url.urlDetail + Url.popular + Url.apiKey) { (movies: Result) in
            self.movies = movies.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        
        cell.configure(movie)
        
        return cell
    }

     // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailViewController
            detailVC.movie = movies[indexPath.row]
        }
    }
}
