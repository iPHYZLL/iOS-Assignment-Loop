//
//  SeznamTekemVC.swift
//  iOS razvojna naloga
//
//  Created by Alen Kirm on 26. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class MatchesVC : UIViewController {
    
    var tekme = [Tekma]() {
        
        didSet {
            if tekme.count > 0 {
                UIView.animate(withDuration: 0.5) {
                    self.infoLabel.alpha = 0
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.infoLabel.alpha = 1
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureNavigationBar()
        
        configureTableView()
        
        layoutUI()
        
        
    }
    
    fileprivate func layoutUI() {
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: view.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        view.layoutSubviews()
        
        view.addSubview(infoLabel)
        infoLabel.anchorCenter(to: view, withHeight: 50, andWidth: view.frame.width)
        
    }
    
    let infoLabel : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        
        let text = NSMutableAttributedString(string: "Press", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)])
        text.append(NSAttributedString(string: " Add match ", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor : l.tintColor]))
        text.append(NSAttributedString(string: "to announce\nand display a match.", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)]))
        
        l.textAlignment = .center
        l.attributedText = text
        return l
    }()
    
    let tableView : UITableView = {
        let tv = UITableView()
        return tv
    }()
    
    fileprivate func configureNavigationBar() {
        self.title = "List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add match", style: .plain, target: self, action: #selector(handleAddMatch))
    }
    
    fileprivate func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ListCell.self, forCellReuseIdentifier: "listCell")
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @objc fileprivate func handleAddMatch() {
        let addMatchVC = AddMatchVC()
        addMatchVC.matchDelegate = self
        
        navigationController?.pushViewController(addMatchVC, animated: true)
    }
    
}

////////////////////////////////////////////////////////
// MARK: table view stuff
////////////////////////////////////////////////////////

extension MatchesVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tekme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListCell else { return UITableViewCell() }
        
        let tekma = tekme[indexPath.row]
        
        cell.dateLabel.text = tekma.datum
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tekme.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tekma = tekme[indexPath.row]
        
        let tekmeVC = MatchVC()
        tekmeVC.tekma = tekma
        
        navigationController?.pushViewController(tekmeVC, animated: true)
        
    }
    
}

////////////////////////////////////////////////////////
// MARK: match delegate stuff
////////////////////////////////////////////////////////

extension MatchesVC : MatchDelegate {
    
    func matchAnnounced(match: Tekma) {
        self.tekme.append(match)
        tableView.reloadData()
    }
    
}










