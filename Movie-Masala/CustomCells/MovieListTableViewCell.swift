//
//  MovieListTableViewCell.swift
//  Movie-Masala
//
//  Created by ESHITA on 23/04/21.
//

import Foundation
import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieCellView: UIView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var bookNowBtnLbl: UIButton!
    
    // Function to get the Movie Data for the MovieList Screen
    func getMovieListData(movies: MovieList){
        
        self.movieCellView.addShadowAndRoundedCorner()
        self.movieNameLabel.text = movies.title
        self.releaseDateLabel.text = HelperFunctions().convertdteFormat(inputDate:  movies.releaseDate)
        self.languageLabel.text = IsoLocaleCodes().find(key: movies.language).name
        self.movieOverviewLabel.text = movies.overview
        self.movieNameLabel.font = UIFont(name: Theme.primeFontName, size: 20)
        self.releaseDateLabel.font = UIFont(name: Theme.bodyFontName, size: 14)
        self.languageLabel.font = UIFont(name: Theme.bodyFontName, size: 14)
        self.movieOverviewLabel.font = UIFont(name: Theme.bodyFontName, size: 14)
        self.bookNowBtnLbl.tag = movies.movieId
        
        guard let url = URL(string: movies.moviePosterURL.absoluteString) else{
            print("Image Not Avaiable!!!")
            return
        }

        DispatchQueue.global().async {
             let data =  try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.moviePosterImageView.image = UIImage(data: data!)

            }
        }
    }
    
  
  //Click evemnt for the individual movie's book now button
    @IBAction func bookNowBtnPressed(_ sender: UIButton) {
        sender.tag = self.bookNowBtnLbl.tag
      
    }
    
    
}

