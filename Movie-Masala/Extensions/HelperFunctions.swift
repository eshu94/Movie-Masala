//
//  HelperFunctions.swift
//  Movie-Masala
//
//  Created by ESHITA on 24/04/21.
//

import Foundation
import UIKit
import CoreData


struct HelperFunctions {
    
    //Function for date conversion
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
        
        let recentMovieTitle = searchedMovieList.enumerated().filter {  $0.offset < 5 }.map { $0.element }
        print(recentMovieTitle)
        clearData()
        
        guard let data = try? JSONEncoder().encode(recentMovieTitle),
           let movieEncodedString = String(data: data, encoding: .utf8) else { return }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SaveMovieTitle", in: managedContext)!
        let movie = NSManagedObject(entity: entity, insertInto: managedContext)
        movie.setValue(movieEncodedString, forKey: "title")
        
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func clearData(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SaveMovieTitle")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let movieObj = try managedContext.fetch(fetchRequest)
            for titleObj in movieObj as! [NSManagedObject] {
                managedContext.delete(titleObj)
            }
           try managedContext.save()
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
              }
    }

}
