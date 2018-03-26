//
//  TekmeVC.swift
//  iOS razvojna naloga
//
//  Created by Alen Kirm on 26. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class MatchVC : UITableViewController {
    
    var tekma : Tekma!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        
        title = "Match"
        
        configureTableView()
        
    }
    
    fileprivate func configureTableView() {
        tableView.register(MatchCell.self, forCellReuseIdentifier: "matchCell")
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    ////////////////////////////////////////////////////////
    // MARK: table view stuff
    ////////////////////////////////////////////////////////
    
    let cellName = ["Team 1:", "Team 2:", "Date:", "Location:", "Score:"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell", for: indexPath) as? MatchCell else { return UITableViewCell() }
        
        cell.nameLabel.text = cellName[indexPath.row]
        cell.valueLabel.isEnabled = false
        
        switch indexPath.row {
        case 0 :
            cell.valueLabel.text = tekma.ekipa1
        case 1 :
            cell.valueLabel.text = tekma.ekipa2
        case 2 :
            cell.valueLabel.text = tekma.datum
        case 3 :
            cell.valueLabel.text = tekma.lokacija
        case 4 :
            cell.valueLabel.text = tekma.rezultat
        default :
            break
        }
        
        return cell
        
    }
    
}
