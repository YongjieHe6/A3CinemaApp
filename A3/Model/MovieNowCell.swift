//
//  MovieNowCell.swift
//  A3
//
//  Created by 何永洁 on 7/5/2023.
//

import Foundation
import UIKit

class MovieNowCell: UITableViewCell {
    
    
    @IBOutlet weak var movieNowNameLabel: UILabel!
    @IBOutlet weak var movieNowImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
