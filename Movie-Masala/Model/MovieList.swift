//
//  MovieList.swift
//  Movie-Masala
//
//  Created by ESHITA on 23/04/21.
//

import Foundation

//All Movie WebService Model
struct MovieItemList : Decodable {
    var  results: [MovieList]
    init(){
        self.results = []
    }
}

struct MovieList: Decodable {
    var movieId:Int
    var title:String
    var releaseDate : String
    var language: String
    var overview:String
    var movieImg:String
    
    private enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case title
        case releaseDate = "release_date"
        case language = "original_language"
        case overview
        case movieImg = "poster_path"
    }
    
    public var moviePosterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(movieImg )")!
    }
}
