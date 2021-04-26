//
//  MovieSearchViewController.swift
//  Movie-Masala
//
//  Created by ESHITA on 25/04/21.
//

import Foundation
import UIKit
import CoreData

class MovieSearchViewController: UIViewController {
    var movies: [NSManagedObject] = []
    var movieList:[String]?
    var searchedMovieList:[String]=[]
    
    @IBOutlet weak var searchedInputTextField:UITextField!
    @IBOutlet weak var searchedMovieListTV:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchedMovieListTV.delegate = self
        self.searchedMovieListTV.dataSource = self
        print(self.movieList as Any)
      
        self.refreshData()
    }
    
    func refreshData(){
        print("refreshData")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SaveMovieTitle")
        
        DispatchQueue.main.async {
            do {
                self.movies = try managedContext.fetch(fetchRequest)
                for i in self.movies{
                    if let decodedMovieString = i.value(forKey: "title") as? String {
                        let data = Data(decodedMovieString.utf8)
                        self.searchedMovieList = try! JSONDecoder().decode([String].self, from: data)
                        print("Recently Searched: ", self.searchedMovieList )
                    }
                }
            } catch let error as NSError {
              print("Could not fetch. \(error), \(error.userInfo)")
            }
            self.searchedMovieListTV.reloadData()
        }
        
    }
    @IBAction func searchIconPressed(_ sender:UIButton){
        print("searchIconPressed")
        guard let searchInput = self.searchedInputTextField.text else {
            self.searchedInputTextField.placeholder = "Please write name to search!!!"
            return
        }
        guard let movieList = self.movieList else {
            fatalError("No movie data")
        }
        self.searchedMovieList = HelperFunctions().getMovies(from: searchInput, movieList: movieList)
        print("savedlist \(self.searchedMovieList)")
        HelperFunctions().saveSearchMovie(searchedMovieList: self.searchedMovieList)
        self.searchedMovieListTV.reloadData()
    }
}

extension MovieSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.searchedMovieListTV.dequeueReusableCell(withIdentifier: "recentlySearchedIdentifier", for: indexPath) as! SearchMovieListTableViewCell
        cell.populateSearchedData(movieTitle: self.searchedMovieList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if( self.searchedMovieList.count == 0){
            return "No Recent Searches"
            
        }else {
            return "Recently Searched:"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.systemGray3.withAlphaComponent(1.0)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont(name: Theme.labelFontNameBold, size:22)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70
   }
}
