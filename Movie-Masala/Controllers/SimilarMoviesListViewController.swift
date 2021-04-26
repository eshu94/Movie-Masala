//
//  SimilarMoviesListViewController.swift
//  Movie-Masala
//
//  Created by ESHITA on 26/04/21.
//

import Foundation
import UIKit

class SimilarMoviesListViewController: UIViewController {
    var similarMovieList: SimilarMovieItemList!
    @IBOutlet weak var similarMoviesCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.similarMoviesCollectionView.delegate = self
        self.similarMoviesCollectionView.dataSource = self
        print("Similar MovieList ViewController")
       }
    
}
//MARK:- Collectionviews functions
extension SimilarMoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similarMovieList.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.similarMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: "ccell", for: indexPath) as! SimilarMovieCollectionViewCell
        cell.populateSimilarMovieData(similiarMovieList: self.similarMovieList.results[indexPath.row])
        return cell
    }
    
    
}
