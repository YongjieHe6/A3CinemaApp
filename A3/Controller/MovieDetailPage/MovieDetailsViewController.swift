//
//  MovieDetailsViewController.swift
//  A3
//
//  Created by 何永洁 on 9/5/2023.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var movieDetail: Movie!
    
    var allShowing = [Ticket]()
    var correctShowingSource = [Ticket]()
    var dateArray = ["Today","Tomorrow","27/05","28/05"]
    
    @IBOutlet weak var movieDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movie Booking"
      
        allShowing  =  loadJson("TicketsSource.json")
        correctShowingSource = allShowing.filter{$0.orderDate == "Today"}
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ?  1 : correctShowingSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            let detailsCell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsCell", for: indexPath) as!  MovieDetailsCell
            
            detailsCell.dateChangeButtonPress = { [self] (index) in
                
                self.correctShowingSource = self.allShowing.filter{$0.orderDate == self.dateArray[index]}
                
                self.movieDetailsTableView.reloadData()
            }
            detailsCell.showMovieDetails(movieDetail)
            
            return detailsCell
        }
        let timeListCell = tableView.dequeueReusableCell(withIdentifier: "SaleTimeListCell", for: indexPath) as! SaleTimeListCell
        
        timeListCell.showMovieTimes(movieTimes: correctShowingSource[indexPath.row])
        timeListCell.bookingButton.tag = indexPath.row
        timeListCell.bookingButton.addTarget( self, action: #selector(bookingButtonTap(button:)), for: .touchUpInside)
        return timeListCell
    }
    
    @objc func bookingButtonTap(button:UIButton){
        let seatSelectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        seatSelectionViewController.ticket = correctShowingSource[button.tag]
        self.navigationController?.pushViewController(seatSelectionViewController, animated: true)
    }
    
}
