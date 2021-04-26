//
//  MovieListTableViewController.swift
//  Movie-Masala
//
//  Created by ESHITA on 23/04/21.
//

import Foundation
import UIKit


class MovieListViewController: UIViewController {
    
    var movies:MovieItemList = MovieItemList()
    
    @IBOutlet weak var movieTableView:UITableView!
    
    @IBOutlet weak var movieSearchBtnLbl: UIButton!
    
    @IBOutlet weak var movieLogoImageView:UIImageView!
    
    var movieListVM: MovieListViewModel = MovieListViewModel()
    var movieDetailVM:MovieDetailViewModel = MovieDetailViewModel()
    var movieTitleList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieTableView.delegate = self
        self.movieTableView.dataSource = self
        self.movieListVM.fetchAllMovies()
        self.movieSearchBtnLbl.titleLabel?.font = UIFont(name: Theme.bodyFontNameBold, size: 30)
        let radian = CGFloat(200 * Double.pi/180)
        UIView.animate(withDuration: 1, delay: 0.1, options: [.curveLinear], animations: {
            self.movieLogoImageView.alpha = 0
            self.movieLogoImageView.transform = CGAffineTransform(rotationAngle: radian)
                .scaledBy(x:2, y: 2)
            let xRotaion = CATransform3DMakeRotation(radian, 10, radian, 10)
            self.movieLogoImageView.layer.transform = CATransform3DConcat(self.movieLogoImageView.layer.transform, xRotaion)
        }){ (success) in
            self.loadData()
           
        }
        
    }
    
    private func loadData(){
        DispatchQueue.main.async {
            self.movieTableView.reloadData()
        }
        print("loadData")
    }
    
    @IBAction func searchViewPressed(_ sender: Any) {
        self.movieTitleList = []
        for movieResult in self.movieListVM.movieList.results {
            self.movieTitleList.append(movieResult.title)
            
        }
        print(self.movieTitleList)
        performSegue(withIdentifier: "searchVCSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailVCSegue" {
            print("prepare details")
            let vc = segue.destination as! MovieDetailViewController
            let sender = sender as! UIButton
            print(sender.tag)
            vc.movieId = sender.tag
        } else if segue.identifier == "searchVCSegue" {
            print("prepare search\(self.movieTitleList)")
            let vc = segue.destination as! MovieSearchViewController
            vc.movieList = self.movieTitleList
        }
        
    }
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieListVM.movieList.results.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.movieTableView.dequeueReusableCell(withIdentifier: "MovieItem") as! MovieListTableViewCell
        cell.getMovieListData(movies: self.movieListVM.movieList.results[indexPath.row])
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    
}
