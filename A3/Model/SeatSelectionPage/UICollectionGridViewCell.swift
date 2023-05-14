//
//  UICollectionGridViewCell.swift
//

import UIKit

class UICollectionGridViewCell: UICollectionViewCell {
    
    //Content tag
    var label:UILabel!
    
    //Arrow icon
    var imageView:UIImageView!
    
    //Left margin
    var paddingLeft:CGFloat = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        
    
        self.label = UILabel(frame: .zero)
        self.label.textAlignment = .center
        self.label.textColor = .black
        self.addSubview(self.label)
        
        self.imageView = UIImageView(frame: .zero)
        self.addSubview(self.imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        label.frame = CGRect(x: paddingLeft, y: 0,
                             width: frame.width - paddingLeft * 2,
                             height: frame.height)
        
        let imageWidth: CGFloat = 25
        let imageHeight: CGFloat = 25
        imageView.frame = CGRect(x:frame.width - imageWidth,
                                 y:frame.height/2 - imageHeight/2,
                                 width:imageWidth, height:imageHeight)
    }
}
