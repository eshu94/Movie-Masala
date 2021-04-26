//
//  SynopsisModel.swift
//  Movie-Masala
//
//  Created by ESHITA on 24/04/21.
//

import Foundation


//MARK:- Synopsis WebService Model

struct SynopsisMovieDetails : Decodable {
    var genres: [Genres]
    var title:String
    var status : String
    var language: String
    var overview:String
    var movieBackDropImg:String
    
    init(){
        self.genres = []
        self.language = ""
        self.movieBackDropImg = ""
        self.status = ""
        self.title = ""
        self.overview=""
    }
    
    private enum CodingKeys: String, CodingKey {
        case genres
        case title
        case status
        case overview
        case language = "original_language"
        case movieBackDropImg = "backdrop_path"
        
    }
    
    public var movieBackDropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(movieBackDropImg )")!
    }
}

struct Genres: Decodable{
    var name:String
}

//MARK:- Reviews Webservice Model
struct AllReviewsList : Decodable {
    var  results: [ReviewList]
    init(){
        self.results = []
    }
}

struct ReviewList: Decodable {
    var authorDetail: AuthorDetail
    var content:String
    var createdDate:String
    private enum CodingKeys: String, CodingKey {
        case authorDetail = "author_details"
        case content
        case createdDate = "created_at"
    }
}

struct AuthorDetail: Decodable{
    var username:String
    var rating:Int?
}

//MARK:- Credits Webservice Model

struct MovieCreditsList: Decodable{
    var cast:[CastList]
    var crew: [CrewList]
    init(){
        self.crew = []
        self.cast = []
    }
}

struct CastList:Decodable{
    var name:String
    var characterName:String
    var castImg:String?
    var department:String
    
    private enum CodingKeys: String, CodingKey {
        case characterName = "character"
        case name
        case castImg = "profile_path"
        case department = "known_for_department"
    }
    
    public var castImgURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(castImg ?? "/null" )")!
    }
    
}

struct CrewList:Decodable{
    var name:String
    var department:String
    var crewImg:String?
    var job:String
    
    private enum CodingKeys: String, CodingKey {
        case department
        case name
        case crewImg = "profile_path"
        case job
    }
    
    public var crewImgURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(crewImg ?? "/null" )")!
    }
}

//MARK:- Similar Movies WebService Model
struct SimilarMovieItemList : Decodable {
    var  results: [SimilarMovieList]
    init(){
        self.results = []
    }
}

struct SimilarMovieList: Decodable {
    var title:String
    var releaseDate : String
    var language: String
    var movieImg:String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case language = "original_language"
        case movieImg = "poster_path"
    }
    
    public var moviePosterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(movieImg )")!
    }
}
