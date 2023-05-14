//
//  ViewController.swift
//  movies
//
//

import UIKit

class ViewController: UIViewController, UICollectionGridViewSelectDelegate {
    var gridViewController: UICollectionGridViewController!
    @IBOutlet weak var totalLab: UILabel!
    @IBOutlet weak var buyBtn: UIButton!
    var ticket: Ticket!
	var chooseSeats = [String]()
    var sumprice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for _ in 0...6 {
            Int(arc4random_uniform(UInt32(15 - 1))) + 1
        }
        self.buyBtn.backgroundColor = UIColor.red
        self.buyBtn.setTitleColor(UIColor.white, for: .normal)
        gridViewController = UICollectionGridViewController()
        gridViewController.setColumns(columns: ["", "", "", "","", "", "", "","", "", "", "","","",""])
        let randomInt1 = Int.random(in: 1...15)
        let randomInt2 = Int.random(in: 1...15)
        let randomInt3 = Int.random(in: 1...15)
        let randomInt4 = Int.random(in: 1...15)
        let randomInt5 = Int.random(in: 1...15)
        let randomInt6 = Int.random(in: 1...15)
        var row1 = ["1"]
        var row2 = ["2"]
        var row3 = ["3"]
        var row4 = ["4"]
        var row5 = ["5"]
        var row6 = ["6"]
        for i in 1...15 {
            if(i == randomInt1){
                row1.append("1")
            }else{
                row1.append("0")
            }
            if(i == randomInt2){
                row2.append("1")
            }else{
                row2.append("0")
            }
            if(i == randomInt3){
                row3.append("1")
            }else{
                row3.append("0")
            }
            if(i == randomInt4){
                row4.append("1")
            }else{
                row4.append("0")
            }
            if(i == randomInt5){
                row5.append("1")
            }else{
                row5.append("0")
            }
            if(i == randomInt6){
                row6.append("1")
            }else{
                row6.append("0")
            }
        }
        gridViewController.addRow(row: row1)
        gridViewController.addRow(row: row2)
        gridViewController.addRow(row: row3)
        gridViewController.addRow(row: row4)
        gridViewController.addRow(row: row5)
        gridViewController.addRow(row: row6)
        gridViewController.selectDelegate = self
        view.addSubview(gridViewController.view)
    }
    
    override func viewDidLayoutSubviews() {
         gridViewController.view.frame = CGRect(x:0, y:50, width:view.frame.width,height:450)
     }

    @IBAction func buttonClick(_ sender: Any) {
        if (chooseSeats.count == 0){
            let alertC = UIAlertController.init(title:"", message:"Select at least one seat please!", preferredStyle: .alert)
            alertC.addAction(UIAlertAction.init(title:"YES", style: .default, handler: nil))
            self.present(alertC, animated: true, completion: nil)
        }else{
			let str = chooseSeats.joined(separator:",")
            ticket.orderTotalPrice = String(sumprice)
            ticket.orderSeatNumbers = str
            var newOrderedTickets =  NSKeyedUnarchiver.unarchiveObject(withFile: userTicketsDocument) as? [Ticket]
            if newOrderedTickets != nil{
                newOrderedTickets!.append(self.ticket)
                NSKeyedArchiver.archiveRootObject(newOrderedTickets!, toFile: userTicketsDocument)
            }else{
                var ticketArray = [Ticket]()
                ticketArray.append(self.ticket)
                NSKeyedArchiver.archiveRootObject(ticketArray, toFile: userTicketsDocument)
            }
            let alertC = UIAlertController.init(title:"", message:"You choose ["+str+"],Successful ticket purchase", preferredStyle: .alert)
            alertC.addAction(UIAlertAction.init(title:"YES", style: .default, handler: { action in self.tabBarController?.selectedIndex = 1
                self.navigationController?.popToRootViewController(animated: true)}))
            self.present(alertC, animated: true, completion: nil)
        }
    }
    
    func tosel(colIndex: Int, rowIndex: Int) -> Int{
        let c = rowIndex
        let r = colIndex
        let seat = String(c) + String(r)
		var rs: Int = 0
		var issel: Int = -1
		for item in chooseSeats {
			if(item == seat){
				chooseSeats.remove(at: chooseSeats.index(of: seat)!)
				issel = 1
			}
		}
		if(issel == -1){
            chooseSeats.append(seat)
			rs = 1
        }
        sumprice = Int(ticket.moviePrice)! * chooseSeats.count
        self.totalLab.text = "Total fee: " + String(sumprice)
		return rs
    }
}
