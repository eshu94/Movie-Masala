//
//  CastCrewListTableViewCell.swift
//  Movie-Masala
//
//  Created by ESHITA on 26/04/21.
//

import Foundation
import UIKit
class CastCrewListTableViewCell:UITableViewCell{
    
    //Cast Cell Items
    
    @IBOutlet weak var movieCastCellView: UIView!

    @IBOutlet weak var castNameLabel: UILabel!
    
    @IBOutlet weak var castCharNameLabel: UILabel!
    
    @IBOutlet weak var castDepartLabel: UILabel!
    
    @IBOutlet weak var castImageView: UIImageView!
    
    //Cast Cell Items
    
    @IBOutlet weak var movieCrewCellView: UIView!

    @IBOutlet weak var crewNameLabel: UILabel!
    
    @IBOutlet weak var crewDepartLabel: UILabel!
    
    @IBOutlet weak var crewJobLabel: UILabel!
    
    @IBOutlet weak var crewImageView: UIImageView!
    
    
    //Functions to populate cell's data
    func getCastDetails(castList: CastList){
        self.movieCastCellView.addShadowAndRoundedCornerForInnerCells()
        self.castNameLabel.text = castList.name
        self.castCharNameLabel.text = castList.characterName
        self.castDepartLabel.text = castList.department
        
        self.castNameLabel.font = UIFont(name: Theme.primeFontName, size: 20)
        self.castCharNameLabel.font = UIFont(name: Theme.bodyFontName, size: 14)
        self.castDepartLabel.font = UIFont(name: Theme.bodyFontName, size: 14)
        
        guard let url = URL(string: castList.castImgURL.absoluteString) else{
            print("Image Not Avaiable!!!")
            return
        }
        
        HelperFunctions().downloadImage(from: url, to: self.castImageView)
        
    }
    
    func getCrewDetails(crewList: CrewList) {
        self.movieCrewCellView.addShadowAndRoundedCornerForInnerCells()
        self.crewNameLabel.text = crewList.name
        self.crewJobLabel.text = crewList.job
        self.crewDepartLabel.text = crewList.department
        
        self.crewNameLabel.font = UIFont(name: Theme.primeFontName, size: 20)
        self.crewJobLabel.font = UIFont(name: Theme.bodyFontName, size: 14)
        self.crewDepartLabel.font = UIFont(name: Theme.bodyFontName, size: 14)
        
        guard let url = URL(string: crewList.crewImgURL.absoluteString) else{
            print("Image Not Avaiable!!!")
            return
        }
        HelperFunctions().downloadImage(from: url, to: self.crewImageView)
    }
    
}
