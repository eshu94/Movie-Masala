//
//  HelperFunctions.swift
//  Movie-Masala
//
//  Created by ESHITA on 24/04/21.
//

import Foundation
import UIKit
//Function for date conversion

struct HelperFunctions {
    
    func convertdteFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
   
        olDateFormatter.dateFormat = "yyyy-MM-dd"

        let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMM, yyyy"
         return convertDateFormatter.string(from: oldDate!)
    }
    
    func convertdteFormatTwo(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
   
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMM, yyyy"
         return convertDateFormatter.string(from: oldDate!)
    }
    
    //Function to get Image
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, to uiImageView: UIImageView) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() {
                uiImageView.image = UIImage(data: data)
            }
        }
    }
    
    //Function the Search movies
    func getMovies(from searchInput:String, movieList:[String]) -> [String] {
        var flag:Bool = false
        var finalResult:[String] = []
        
        for movie in movieList {
            if(searchInput.count == 1){
                let tempArray = movie.lowercased().components(separatedBy: " ")
                for title in tempArray{
                    if(title.starts(with: searchInput.lowercased())){
                        flag = true
                        break
                    }else{
                        flag = false
                    }
                }
                if(flag){
                    finalResult.append(movie)
                }
            }else{
                let tempArray = searchInput.components(separatedBy: " ")
                var counter = 0
                for item in tempArray{
                    if(movie.range(of: item, options: .caseInsensitive) != nil){
                        counter += 1
                    }
                }
                
                if(counter == tempArray.count){
                    finalResult.append(movie)
                }
            }
        }
        return finalResult
    }
    
    //Function to save searched movieList
    func saveSearchMovie(searchedMovieList: [String]){
        let defaults = UserDefaults.standard
        if (searchedMovieList.count > 0 && searchedMovieList.count == 5){
            defaults.setValue(searchedMovieList, forKey: "searchedMovie")
        }/*else if(searchedMovieList.count > 5 ){
            var movieList:[String] = []
            for item in 0...5 {
                movieList[item] = searchedMovieList[item]
            }
            defaults.setValue(movieList, forKey: "searchdMovie")*/
        //}
    }

}
