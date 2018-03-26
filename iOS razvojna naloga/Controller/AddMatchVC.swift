//
//  AddMatchVC.swift
//  iOS razvojna naloga
//
//  Created by Alen Kirm on 26. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

protocol MatchDelegate {
    
    func matchAnnounced(match : Tekma)
    
}

class AddMatchVC : UITableViewController {
    
    var matchDelegate : MatchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
        
        configureTableView()
        
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        dismissKeyboardGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(dismissKeyboardGesture)
        
    }
    
   @objc fileprivate func hideKeyboard() {
        view.endEditing(true)
    }
    
    fileprivate func configureNavigationBar() {
        self.title = "Add match"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(handleOK))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    fileprivate func configureTableView() {
        tableView.register(MatchCell.self, forCellReuseIdentifier: "matchCell")
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.keyboardDismissMode = .onDrag
    }
    
    let datePicker : UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.locale = Locale.init(identifier: "sl_SI")
        return dp
    }()
    
    @objc fileprivate func handleOK() {
        
        var ekipa1 : String!
        var ekipa2 : String!
        var date : String!
        var location : String!
        var score : String!

        for cell in tableView.visibleCells {
            
            guard let matchCell = cell as? MatchCell else { continue }
            
            switch tableView.indexPath(for: matchCell)?.row {
            case 0 :
                ekipa1 = matchCell.valueLabel.text ?? ""
            case 1 :
                ekipa2 = matchCell.valueLabel.text ?? ""
            case 2 :
                if let dateProvided = matchCell.valueLabel.text, dateProvided != "" {
                    date = dateProvided
                } else {
                    let currentDate = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd. MM. yyyy"
                    
                    date = formatter.string(from: currentDate)
                }
            case 3 :
                location = matchCell.valueLabel.text ?? ""
            case 4 :
                score = matchCell.valueLabel.text ?? ""
            default :
                break
            }
            
        }
        
        print("\(Date())")
        
        let tekma = Tekma(ekipa1: ekipa1, ekipa2: ekipa2, datum: date, lokacija: location, rezultat: score)
        
        if let matchDelegate = matchDelegate {
            print("Tekma:", tekma)
            matchDelegate.matchAnnounced(match: tekma)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc fileprivate func handleCancel() {
        navigationController?.popToRootViewController(animated: true)
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
        
        if indexPath.row == 2 {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "IZBERI", style: .done, target: self, action: #selector(handleDatePicked))
            toolbar.setItems([doneButton], animated: true)
            cell.valueLabel.inputAccessoryView = toolbar
            cell.valueLabel.inputView = datePicker
            
        }
        
        return cell
        
    }
    
    @objc func handleDatePicked() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd. MM. yyyy"
        dateFormatter.locale = Locale.init(identifier: "sl_SI")
        
        // hardcoded, not good ...
        guard let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? MatchCell else { return }
        
        cell.valueLabel.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
}
