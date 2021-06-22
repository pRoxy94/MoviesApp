//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Rossana Laricchia on 17/05/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieContentView: UIView!

    
    // paragonabile al viewDidLoad, qui inizializzeremo gli elementi
    override func awakeFromNib() {
        super.awakeFromNib()
        // personalizziamo la tableview
        self.movieContentView.layer.cornerRadius = 10
        self.movieImageView.layer.cornerRadius = 30
    }

    // viene invocato quando l'utente clicca sulla cella. Si usa solo per modificare lo stato della view selezionata ovvero degli elementi presenti nella tableViewCell. Esempio: modificare il colore di un elemento quando l'utente clicca sulla cella.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
