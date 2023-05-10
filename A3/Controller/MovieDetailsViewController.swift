//
//  MovieDetailsViewController.swift
//  A3
//
//  Created by 何永洁 on 9/5/2023.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    var movieDetail: Movie!
  /*
    var movieDetail:Movie!
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
            
            detailsCell.segementButtonClick = { [self] (index) in
                
                self.datasource = self.allData.filter{$0.saleDate == self.dateArray[index]}
                
                self.tableView.reloadData()
            }
            cell.showModelWith(detailModel)
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaleMovieListCell", for: indexPath) as! SaleMovieListCell
        
        cell.showModel(model: datasource[indexPath.row])
        cell.buyButton.tag = indexPath.row
        cell.buyButton.addTarget( self, action: #selector(buyButtonClick(button:)), for: .touchUpInside)
        return cell
    }
    
    @objc func buyButtonClick(button:UIButton){
        
        let seatViewController = UIStoryboard(name: "Cinema", bundle: nil).instantiateViewController(withIdentifier: "SeatSelectionViewController") as! SeatSelectionViewController
        vc.ticket = datasource[button.tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    */
}
