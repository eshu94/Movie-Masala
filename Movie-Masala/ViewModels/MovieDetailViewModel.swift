//
//  MovieDetailViewModel.swift
//  Movie-Masala
//
//  Created by ESHITA on 24/04/21.
//

import Foundation
import UIKit


class MovieDetailViewModel{
    
    var movieCreditList:MovieCreditsList = MovieCreditsList()
    var movieReviewList: AllReviewsList = AllReviewsList()
    var movieSimiliarList:SimilarMovieItemList = SimilarMovieItemList()
    var movieSynopsisList: SynopsisMovieDetails = SynopsisMovieDetails()
    
    func getMovieDetail(movieId:Int){
        self.getSynopsis(movieId: movieId)
        self.getReviews(movieId: movieId)
        self.getCredits(movieId: movieId)
        self.getSimilarMovies(movieId: movieId)
    }

    //MARK:- Function to get Synopsis
    func getSynopsis(movieId:Int) {
        TheMovieDBWebservice().getSysnopsisDetails(movieId: movieId) { synopsisMovieItem in
            if let synopsisMovieItem = synopsisMovieItem {
                self.movieSynopsisList.title = synopsisMovieItem.title
                self.movieSynopsisList.genres = synopsisMovieItem.genres
                self.movieSynopsisList.status = synopsisMovieItem.status
                self.movieSynopsisList.language = synopsisMovieItem.language
                self.movieSynopsisList.overview = synopsisMovieItem.overview
                self.movieSynopsisList.movieBackDropImg = synopsisMovieItem.movieBackDropImg
               
            }
        }
      
    }
    
    //MARK:- Function to get Reviews
    func getReviews(movieId:Int) {
        TheMovieDBWebservice().getReviewDetails(movieId: movieId) { moviereviewList in
            if let moviereviewList = moviereviewList {
                self.movieReviewList.results = moviereviewList
            }
        }
    }
    
    //MARK:- Function to get Credits
    func getCredits(movieId:Int) {
        TheMovieDBWebservice().getCreditDetails(movieId: movieId) { movieCreditItemList in
            if let movieCreditItemList = movieCreditItemList {
                self.movieCreditList = movieCreditItemList
            }
        }
      
    }
    
    //MARK:- Function to get Similar
    func getSimilarMovies(movieId:Int) {
        TheMovieDBWebservice().getSimiliarMoviesDetails(movieId: movieId) { similarMovieItemList in
            if let similarMovieItemList = similarMovieItemList {
                self.movieSimiliarList.results = similarMovieItemList
            }
        }
      
    }
    
    
}
