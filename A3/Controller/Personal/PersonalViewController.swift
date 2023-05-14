//
//  PersonalViewController.swift
//  A3
//
//  Created by wd on 2023/5/10.
//

import UIKit

class PersonalViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var datasource: [Ticket] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        var userTicketsData =  NSKeyedUnarchiver.unarchiveObject(withFile: userTicketsDocument) as? [Ticket]
        datasource = userTicketsData ?? []
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickLogout(_ sender: UIButton) {
        let alet = UIAlertController(title: "Sure to Log Out?", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Sure", style: .default) { action in
            
            if let window = UIApplication.shared.connectedScenes.first?.value(forKeyPath:"delegate.window") as? UIWindow {
                
                let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                let navigationController = UINavigationController(rootViewController: loginViewController)
                window.rootViewController = navigationController
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alet.addAction(okAction)
        alet.addAction(cancelAction)
        present(alet, animated: true)
    }
    
    
}

extension PersonalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalHeaderTableViewCell", for: indexPath)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalTiketsCell", for: indexPath)
        
        if let ticketCell = cell as? PersonalTiketsCell, datasource.count > indexPath.row {
            
            let ticket = datasource[indexPath.row]
            
            ticketCell.timeLabel.text = "\(ticket.orderDate) \(ticket.movieShowTime)"
            ticketCell.seatNumberLabel.text = ticket.orderSeatNumbers
            ticketCell.totalPriceLabel.text = "$\(ticket.orderTotalPrice ?? "0")"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if indexPath.section == 1 {
            return true
        }
        
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard indexPath.section == 1, editingStyle == .delete else {
            return
        }
        
        guard datasource.count > indexPath.row else {
            return
        }
        
        let alet = UIAlertController(title: "You sure to delete this ticket?", message: nil, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Sure", style: .default) { action in
            
            self.datasource.remove(at: indexPath.row)
            NSKeyedArchiver.archiveRootObject(self.datasource, toFile: userTicketsDocument)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alet.addAction(okAction)
        alet.addAction(cancelAction)
        present(alet, animated: true)
        self.tableView.reloadData()
    }
}
