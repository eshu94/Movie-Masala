//
//  MovieDetailViewController.swift
//  Movie-Masala
//
//  Created by ESHITA on 24/04/21.
//

import Foundation
import UIKit


class MovieDetailViewController: UIViewController{

    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieGenereLbl: UILabel!
    @IBOutlet weak var movieStatusLbl: UILabel!
    @IBOutlet weak var movieLanguageLbl: UILabel!
    @IBOutlet weak var movieBackDropImageView: UIImageView!
    @IBOutlet weak var movieOverviewLbl:UILabel!
    @IBOutlet weak var movieReviewTableView:UITableView!
    
    var movieDetailVM: MovieDetailViewModel = MovieDetailViewModel()
    var movieId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieReviewTableView.delegate = self
        self.movieReviewTableView.dataSource = self
        self.movieReviewTableView.backgroundColor = UIColor.clear
        print("movieDetailDelegate\(String(describing: self.movieId))")
        guard let movieId = self.movieId else{
            fatalError("Id not found")
        }
        self.movieDetailVM.getMovieDetail(movieId: movieId)
        print("viewDidLoad")
       //  self.loadMovieData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewWillAppear")
        guard let movieId = self.movieId else{
            fatalError("Id not found")
        }
        self.movieDetailVM.getMovieDetail(movieId: movieId)
        self.loadMovieData()
    }
  
    private func loadMovieData(){
        print("LoadMovieData")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.movieReviewTableView.reloadData()
            self.movieTitleLbl.text = "Title: \(self.movieDetailVM.movieSynopsisList.title)"
            var genre = ""
            for item in self.movieDetailVM.movieSynopsisList.genres {
                 genre += item.name + ", "
            }
            self.movieGenereLbl.text = "Genere: \(genre)"
            self.movieStatusLbl.text = "Status: \(self.movieDetailVM.movieSynopsisList.status)"
            self.movieLanguageLbl.text = "Language: \(IsoLocaleCodes().find(key:self.movieDetailVM.movieSynopsisList.language).name)"
            self.movieBackDropImageView.alpha = 0.3
            guard let url = URL(string: self.movieDetailVM.movieSynopsisList.movieBackDropURL.absoluteString) else{
                print("Image Not Avaiable!!!")
                return
            }
            HelperFunctions().downloadImage(from: url, to: self.movieBackDropImageView)
            self.movieOverviewLbl.text = "Overview: \(self.movieDetailVM.movieSynopsisList.overview)"
            
        }
       
    }
    
    //Cast & Crew button click
    
    @IBAction func castCrewBtnPressed(_ sender:UIButton){
        self.performSegue(withIdentifier: "CastCrewVCSegue", sender: sender)
    }
    
    //Similar movies button click
    
    @IBAction func similarMovieBtnPressed(_ sender:UIButton){
        self.performSegue(withIdentifier: "SimilarMovieVCSegue", sender: sender)
        
    }
    
    //Segue Operations
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CastCrewVCSegue"{
            
            print("prepare CastCrew Segue\(self.movieDetailVM.movieCreditList)")
            let castCrewVC = segue.destination as! CastCrewListViewController
            castCrewVC.movieCastList = self.movieDetailVM.movieCreditList.cast
            castCrewVC.movieCrewList = self.movieDetailVM.movieCreditList.crew
            
        }else if segue.identifier == "SimilarMovieVCSegue"{
            
            print("prepare Similar movie Segue\(self.movieDetailVM.movieSimiliarList)")
            let similarMovieVC = segue.destination as! SimilarMoviesListViewController
            similarMovieVC.similarMovieList = self.movieDetailVM.movieSimiliarList
        }
    }
}
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieDetailVM.movieReviewList.results.count
        //return 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.movieReviewTableView.dequeueReusableCell(withIdentifier: "ReviewCCIdentifier") as! MovieReviewTableViewCell
        cell.getMovieReviewListData(reviewList: self.movieDetailVM.movieReviewList.results[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 195
   }
    
}
