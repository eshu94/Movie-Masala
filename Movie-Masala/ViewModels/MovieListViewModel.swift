//
//  MovieListViewModel.swift
//  Movie-Masala
//
//  Created by ESHITA on 23/04/21.
//

import Foundation

struct Movies: Decodable {
    let result:MovieList
    
    var title: String {
        return self.result.title
    }
    var releaseDate: String {
        return self.result.releaseDate
    }
    var language: String {
        return self.result.language
    }
    
    var overview: String{
        return self.result.overview
    }
    var movieImg: String{
        return self.result.movieImg
    }

}

class MovieListViewModel{
    
    let  movieTitle:String
    let movieReleaseDate : String
    let movieLanguage: String
    let movieOverview:String
    let movieImgPath:String
    var movieList:MovieItemList = MovieItemList()
    
    init() {
        self.movieTitle = ""
        self.movieReleaseDate = ""
        self.movieLanguage = ""
        self.movieOverview = ""
        self.movieImgPath = ""
        //self.movieList =
    }
    
     func fetchAllMovies(){
        TheMovieDBWebservice().getAllMovies { movieList in
            if let movieList = movieList {
                self.movieList.results = movieList
            }
         print("fetchAllMovies")
        }
            
    }
    
}
