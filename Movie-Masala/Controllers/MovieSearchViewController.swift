//
//  MovieSearchViewController.swift
//  Movie-Masala
//
//  Created by ESHITA on 25/04/21.
//

import Foundation
import UIKit

class MovieSearchViewController: UIViewController {
    var movieList:[String]?
    let defaults = UserDefaults.standard
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
        
        DispatchQueue.main.async {
            if(self.defaults.array(forKey: "searchedMovie") != nil) {
                self.searchedMovieList = (self.defaults.array(forKey: "searchedMovie") as? [String] ?? [])
                print(self.searchedMovieList)
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
            return "Recently Searched"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.systemGray6.withAlphaComponent(1.0)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont(name: Theme.labelFontNameBold, size:25)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70
   }
}
