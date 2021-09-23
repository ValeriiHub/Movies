//
//  MoviesTableViewController.swift
//  Movies
//
//  Created by Valerii D on 19.09.2021.
//

import UIKit

// MARK: - PopularTableViewController

class PopularTableViewController: UITableViewController {
    
    // MARK: - Private properties
    
    private var movies: [Movie] = []
    private var networking: NetworkingProtocol = Networking.shared
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking.fetchPopular { movies in
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
