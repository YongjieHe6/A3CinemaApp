//
//  SaleTimeListCell.swift
//  A3
//
//  Created by 何永洁 on 10/5/2023.
//

import Foundation
import UIKit

class SaleTimeListCell: UITableViewCell {
    
    @IBOutlet weak var moviePriceLabel: UILabel!
    @IBOutlet weak var movieStartTimeLabel: UILabel!
    @IBOutlet weak var bookingButton: UIButton!
    func showMovieTimes(movieTimes:Ticket){
        moviePriceLabel.text = "$\(movieTimes.moviePrice)"
        movieStartTimeLabel.text = movieTimes.movieShowTime
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bookingButton.layer.borderColor = UIColor.systemPink.cgColor
        bookingButton.layer.borderWidth = 1
        bookingButton.layer.cornerRadius = 4
        bookingButton.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
