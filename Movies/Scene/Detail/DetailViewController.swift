//
//  DetailViewController.swift
//  Movies
//
//  Created by Rossana Laricchia on 17/05/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    
    // variabile d'appoggio poiché dal prepareForSegue del MovieViewController non possiamo accedere alle proprietà grafiche visto che non sono ancora inizializzate
    var receivedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieImage.image = self.receivedMovie?.image
        self.movieTitle.text = self.receivedMovie?.title
        self.movieOverview.text = self.receivedMovie?.description
    }
}
