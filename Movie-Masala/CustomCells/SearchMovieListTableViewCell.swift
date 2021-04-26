//
//  SearchMovieListTableViewCell.swift
//  Movie-Masala
//
//  Created by ESHITA on 26/04/21.
//

import Foundation
import UIKit

class SearchMovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel:UILabel!
    @IBOutlet weak var searchedMovieViewCell:UIView!
    
    func populateSearchedData(movieTitle:String){
        self.movieTitleLabel.text = movieTitle
        self.movieTitleLabel.font = UIFont(name: Theme.labelFontNameBold, size: 20)
        self.movieTitleLabel.textColor = Theme.label
    }
    
}
