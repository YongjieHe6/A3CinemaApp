//
//  UICollectionGridViewController.swift
//
//

import Foundation
import UIKit

protocol UICollectionGridViewSelectDelegate {
    func tosel(colIndex: Int, rowIndex: Int) -> Int
}

class UICollectionGridViewController: UICollectionViewController {
    var cols: [String]! = []
    var rows: [[Any]]! = []
    
    var selectDelegate:UICollectionGridViewSelectDelegate!
    private var selectedSectionIndex = -1
    private var selectedColIdx = -1
    
    init() {
        //init layout
        let layout = UICollectionGridViewLayout()
        super.init(collectionViewLayout: layout)
        layout.viewController = self
        collectionView!.backgroundColor = UIColor.white
        collectionView!.register(UICollectionGridViewCell.self,
                                      forCellWithReuseIdentifier: "cell")
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView!.isDirectionalLockEnabled = true
        collectionView!.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView!.bounces = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("UICollectionGridViewController.init(coder:) has not been implemented")
    }
    
    //set col data
    func setColumns(columns: [String]) {
        cols = columns
    }
    
    //add data
    func addRow(row: [Any]) {
        rows.append(row)
        collectionView!.collectionViewLayout.invalidateLayout()
        collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        collectionView!.frame = CGRect(x:0, y:80,
                                       width:view.frame.width, height:450)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //return table rows count
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
            if cols.isEmpty {
                return 0
            }
            return rows.count + 1
    }
    
    //return table cols count
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return cols.count
    }
    
    //cell create
    override func collectionView(_ collectionView: UICollectionView,
                            cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! UICollectionGridViewCell
        
        if indexPath.section == 0 {
            let text = NSAttributedString(string: cols[indexPath.row], attributes: [
                NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 15)
                ])
            cell.label.attributedText = text
        } else {
            let text = "\(rows[indexPath.section-1][indexPath.row])"
            if indexPath.row == 0 {
                cell.label.font = UIFont.systemFont(ofSize: 14)
                cell.label.text = "\(rows[indexPath.section-1][indexPath.row])"
            }else{
                cell.label.text = ""
                if(text == "1"){
                    cell.imageView.image = UIImage(named: "redseat")
                }else if(text == "2"){
                    cell.imageView.image = UIImage(named: "greenseat")
                }else{
                    cell.imageView.image = UIImage(named: "whiteseat")
                }
            }
            if indexPath.section == selectedSectionIndex && indexPath.row == selectedColIdx {
                cell.imageView.image = UIImage(named: "greenseat")
            }
        }
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let cell = self.collectionView.cellForItem(at: indexPath) as! UICollectionGridViewCell
		let text = "\(rows[indexPath.section-1][indexPath.row])"
		if(text=="1"){
		    let alertC = UIAlertController.init(title:"", message:"The seat has already been purchased.", preferredStyle: .alert)
            alertC.addAction(UIAlertAction.init(title:"YES", style: .default, handler: nil))
            self.present(alertC, animated: true, completion: nil)
		}else{
			selectedSectionIndex = indexPath.section
			selectedColIdx = indexPath.row
			let rs = selectDelegate.tosel(colIndex: indexPath.row, rowIndex: indexPath.section)
			if(rs==1){
				cell.imageView?.image = UIImage(named: "greenseat")
			}else{
				cell.imageView?.image = UIImage(named: "whiteseat")
			}
		}
    }
    
    func updatesel(selseats: [String]){
        for item in selseats {
            let s = item.prefix(1)
            let r = item.suffix(item.count - 1)
            let indexPath = IndexPath(item: Int(r)!,section: Int(s)!)
            let cell = self.collectionView.cellForItem(at: indexPath) as! UICollectionGridViewCell
            cell.imageView?.image = UIImage(named: "redseat")
        }
    }
}
