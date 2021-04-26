//
//  MovieReviewTableViewCell.swift
//  Movie-Masala
//
//  Created by ESHITA on 25/04/21.
//

import Foundation
import UIKit

class MovieReviewTableViewCell:UITableViewCell{
    
    @IBOutlet weak var movieReviewCellView: UIView!
    
    @IBOutlet weak var movieReviewUsernameLabel: UILabel!
    
    @IBOutlet weak var movieReviewCreatedDateLabel: UILabel!
    
    @IBOutlet weak var movieReviewRatingLabel: UILabel!
    
    @IBOutlet weak var movieReviewContentLabel: UITextView!
    
    // Function to get the Movie Data for the MovieList Screen
    func getMovieReviewListData(reviewList: ReviewList){
        
        self.movieReviewCellView.addShadowAndRoundedCorner()
        self.movieReviewCellView.backgroundColor = UIColor.clear
        self.movieReviewUsernameLabel.text = "Username:\(reviewList.authorDetail.username)"
        self.movieReviewCreatedDateLabel.text = "CreatedDate:\(HelperFunctions().convertdteFormatTwo(inputDate:  reviewList.createdDate))"
        self.movieReviewRatingLabel.text = "Rating:\(reviewList.authorDetail.rating ?? 0)"
        self.movieReviewContentLabel.text = reviewList.content
        self.movieReviewUsernameLabel.font = UIFont(name: Theme.primeFontName, size: 20)
        self.movieReviewCreatedDateLabel.font = UIFont(name: Theme.bodyFontName, size: 14)
        self.movieReviewRatingLabel.font = UIFont(name: Theme.bodyFontName, size: 14)
        self.movieReviewContentLabel.font = UIFont(name: Theme.bodyFontName, size: 14)
       
        
    }
    
}
