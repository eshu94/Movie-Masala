//
//  SimilarMovieCollectionViewCell.swift
//  Movie-Masala
//
//  Created by ESHITA on 26/04/21.
//

import Foundation
import UIKit

class SimilarMovieCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var similiarMovieCellView: UIView!
    
    @IBOutlet weak var similarMovieNameLabel: UILabel!
    
    @IBOutlet weak var similarMovieRDateLabel: UILabel!
    
    @IBOutlet weak var similarMovieLanguageLabel: UILabel!
    
    @IBOutlet weak var similarMoviePosterImageView: UIImageView!
    
    func populateSimilarMovieData(similiarMovieList:SimilarMovieList){
        self.similiarMovieCellView.addShadowAndRoundedCornerForCollectionCells()
        self.similarMovieNameLabel.text = similiarMovieList.title
        self.similarMovieRDateLabel.text = HelperFunctions().convertdteFormat(inputDate: similiarMovieList.releaseDate)
        self.similarMovieLanguageLabel.text = IsoLocaleCodes().find(key: similiarMovieList.language).name
        guard let url = URL(string: similiarMovieList.moviePosterURL.absoluteString) else {
            fatalError("NOT FOUND")
        }
        HelperFunctions().downloadImage(from: url, to: self.similarMoviePosterImageView)
        
    }
    
}
