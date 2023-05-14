//
//  AllMoviesViewController.swift
//  A3
//
//  Created by Yongjie He on 7/5/2023.
//

import Foundation
import UIKit

class AllMoviesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var upcomingMoviesButton: UIButton!
    @IBOutlet weak var nowMoviesButton: UIButton!
    @IBOutlet weak var moviesTableView: UITableView!
    
    var classificationCurrentIndex = 0
    var classificationButtonArray = [UIButton]()
    var allMovies = [Movie]()
    var correctMovieSources = [Movie]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        allMovies  =  loadJson("MoviesSource.json")
        classificationButtonArray = [nowMoviesButton,upcomingMoviesButton]
        correctMovieSources = allMovies.filter{$0.movieClassification == "0"}
    }
    
    @IBAction func showCorrectMovies(_ sender: UIButton) {
        correctMovieSources = allMovies.filter{$0.movieClassification == "\(sender.tag)"}
        classificationCurrentIndex = sender.tag
        classificationButtonArray.forEach { tappedButtton in
            if tappedButtton == sender{
                tappedButtton.setTitleColor(.red, for: .normal)
            }else{
                tappedButtton.setTitleColor(.lightGray, for: .normal)
            }
        }
        moviesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return correctMovieSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if classificationCurrentIndex == 0{
            let moviesNowCell = tableView.dequeueReusableCell(withIdentifier: "MovieNowCell", for: indexPath) as! MovieNowCell
            
            let moviesCard = correctMovieSources[indexPath.row]
            moviesNowCell.movieNowNameLabel.text = moviesCard.movieName
            moviesNowCell.movieNowImage.image = UIImage(named: "\(moviesCard.movieImage)")
            
            return moviesNowCell
        }
        
        let moviesLaterCell = tableView.dequeueReusableCell(withIdentifier: "MovieLaterCell", for: indexPath) as! MovieLaterCell
        let moviesCard = correctMovieSources[indexPath.row]
        moviesLaterCell.movieLaterNameLabel.text = moviesCard.movieName
        moviesLaterCell.movieLaterImage.image = UIImage(named: "\(moviesCard.movieImage)")
        
        return moviesLaterCell
        
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        
        detailViewController.movieDetail = self.correctMovieSources[indexPath.row]
        detailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
