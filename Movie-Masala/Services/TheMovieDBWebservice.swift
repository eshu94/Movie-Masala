//
//  TheMovieDBWebservice.swift
//  Movie-Masala
//
//  Created by ESHITA on 23/04/21.
//

import Foundation


class TheMovieDBWebservice {
    
    let apiKey:String
    var nsDictionary: NSDictionary
    
    init(){
        
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError()
        }
        
        self.nsDictionary = NSDictionary(contentsOfFile: path)!
        self.apiKey = self.nsDictionary["API_KEY"] as? String ?? "api_key"
    }
    
    // MARK:- Function to get All movies for Movie List Screen
    func getAllMovies(completion: @escaping (([MovieList]?) -> Void)) {

        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(self.apiKey)") else {
                   fatalError("URL is not correct")
               }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
           
            let movieItemsList = try? JSONDecoder().decode(MovieItemList.self, from: data)
        
            DispatchQueue.main.async {
                if let movieItemsList = movieItemsList {
                    completion(movieItemsList.results)
                }
            }
            
        }.resume()
        
    }
    
    // MARK:- Function to get synopis webservice
    
    func getSysnopsisDetails(movieId:Int, completion: @escaping ((SynopsisMovieDetails?) -> Void)) {
        print("getSysnopsisDetails: Start")
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(self.apiKey)") else {
                   fatalError("URL is not correct")
               }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return
            }
           
            let movieSynopisDetail = try? JSONDecoder().decode(SynopsisMovieDetails.self, from: data)
            if let movieSynopisDetail = movieSynopisDetail {
                print(movieSynopisDetail)
                completion(movieSynopisDetail)
            }
            
        }.resume()
        
    }
    
    //MARK:- Func to get reviews webservice
    
     func getReviewDetails(movieId:Int, completion: @escaping (([ReviewList]?) -> Void)) {
        print("getReviewDetails: Start")
         guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=\(self.apiKey)") else {
                    fatalError("URL is not correct")
                }
         
         URLSession.shared.dataTask(with: url) { data, response, error in
             
             guard let data = data, error == nil else {
                 return
             }
            
             let movieReviewDetails = try? JSONDecoder().decode(AllReviewsList.self, from: data)
             DispatchQueue.main.async {
                 if let movieReviewDetails = movieReviewDetails {
                    print(movieReviewDetails.results)
                    completion(movieReviewDetails.results)
                 }
             }
             
         }.resume()
         
     }
    
    
    //MARK:- Func to get credits webservice
    
     func getCreditDetails(movieId:Int, completion: @escaping ((MovieCreditsList?) -> Void)) {
        print("getCreditDetails: Start")
         guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(self.apiKey)") else {
                    fatalError("URL is not correct")
                }
         
         URLSession.shared.dataTask(with: url) { data, response, error in
             
             guard let data = data, error == nil else {
                 return
             }
             let movieCreditDetails = try? JSONDecoder().decode(MovieCreditsList.self, from: data)
            
 
            if let movieCreditDetails = movieCreditDetails {
               print(movieCreditDetails.cast)
                completion(movieCreditDetails)
            }
         }.resume()
         
     }
    
    //MARK:- Func to get similar movies webservice
    
    func getSimiliarMoviesDetails(movieId:Int, completion: @escaping (([SimilarMovieList]?) -> Void)) {
        print("getSimiliarMoviesDetails: Start")
         guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/similar?api_key=\(self.apiKey)") else {
                    fatalError("URL is not correct")
                }
         
         URLSession.shared.dataTask(with: url) { data, response, error in
             
             guard let data = data, error == nil else {
                 return
             }
            
             let similiarMoviesDetails = try? JSONDecoder().decode(SimilarMovieItemList.self, from: data)
         
             DispatchQueue.main.async {
                 if let similiarMoviesDetails = similiarMoviesDetails {
                    print(similiarMoviesDetails.results)
                    completion(similiarMoviesDetails.results)
                 }
             }
             
         }.resume()
         
     }
    
}
