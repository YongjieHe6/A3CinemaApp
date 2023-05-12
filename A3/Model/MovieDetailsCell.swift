//
//  MovieDetailsCell.swift
//  A3
//
//  Created by 何永洁 on 10/5/2023.
//

import Foundation
import UIKit

class MovieDetailsCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieRunningTimeLabel: UILabel!
    
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var afterTomorrowButton: UIButton!
    @IBOutlet weak var lastDayButton: UIButton!
    
    @IBOutlet weak var todaySelectionLine: UIView!
    @IBOutlet weak var tomorrowSelectionLine: UIView!
    @IBOutlet weak var afterTomorrowSelectionLine: UIView!
    @IBOutlet weak var lastDaySelectionLine: UIView!
    
    var dateChangeButtonPress:((_ index:Int)->(Void))?
    
    var dateButtonArray:[UIButton]{
        
        return [todayButton,tomorrowButton,afterTomorrowButton,lastDayButton]
    }
    
    var dateSelectionLineArray:[UIView]{
        
        return [todaySelectionLine,tomorrowSelectionLine,afterTomorrowSelectionLine,lastDaySelectionLine]
    }
    
    @IBAction func dateChangeButtonTap(_ sender: UIButton) {
        for dateButton in dateButtonArray{
            if dateButton == sender{
                dateButton.setTitleColor(.black, for: .normal)
                dateSelectionLineArray[sender.tag-10].isHidden = false
                dateChangeButtonPress!(sender.tag-10)
            }else{
                dateButton.setTitleColor(.lightGray, for: .normal)
                dateSelectionLineArray[sender.tag-10].isHidden = true
            }
        }
        for dateSelectionLine in dateSelectionLineArray{
            
            if dateSelectionLine.tag == sender.tag + 10{
                dateSelectionLine.isHidden = false
            }else{
                dateSelectionLine.isHidden = true
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func showMovieDetails(_ correctMovie:Movie){
        
        movieImage.image = UIImage(named: "\(correctMovie.movieImage)")
        movieNameLabel.text = correctMovie.movieName
        movieReleaseDateLabel.text = "Release date：\(correctMovie.movieShowTime)"
        movieRunningTimeLabel.text = "Running Time：\(correctMovie.movieRunningTime) min"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
