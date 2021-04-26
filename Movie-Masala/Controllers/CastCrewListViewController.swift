//
//  CastCrewListViewController.swift
//  Movie-Masala
//
//  Created by ESHITA on 26/04/21.
//

import Foundation
import UIKit

class CastCrewListViewController: UIViewController{
    
    var movieCastList: [CastList]!
    var movieCrewList: [CrewList]!
    @IBOutlet weak var movieCastListTableView:UITableView!
    @IBOutlet weak var movieCrewListTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Cast&Crew ViewController")
        self.movieCastListTableView.delegate = self
        self.movieCrewListTableView.delegate = self
        self.movieCastListTableView.dataSource = self
        self.movieCrewListTableView.dataSource = self
    }
    
}
extension CastCrewListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView === self.movieCastListTableView{
            let castCell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCustomCell", for: indexPath) as! CastCrewListTableViewCell
            castCell.getCastDetails(castList: self.movieCastList[indexPath.row])
            return castCell
        }else if tableView === self.movieCrewListTableView {
            let crewCell = tableView.dequeueReusableCell(withIdentifier: "CrewTableViewCustomCell", for: indexPath) as! CastCrewListTableViewCell
            crewCell.getCrewDetails(crewList: self.movieCrewList[indexPath.row])
            return crewCell
        }
        return UITableViewCell.init()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === self.movieCastListTableView{
            return self.movieCastList.count
        }else if tableView === self.movieCrewListTableView {
            return self.movieCrewList.count
        }
        return Int.init()
    }
    
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView === self.movieCastListTableView{
            return "Cast"
        }else if tableView === self.movieCrewListTableView {
            return "Crew"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(1.0)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
        (view as! UITableViewHeaderFooterView).textLabel?.font = UIFont(name: Theme.labelFontNameBold, size:30)
    }
  
}
