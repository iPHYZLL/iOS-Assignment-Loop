//
//  ListCell.swift
//  iOS razvojna naloga
//
//  Created by Alen Kirm on 26. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class ListCell : UITableViewCell {
    
    let dateLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18)
        return l
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        addSubview(dateLabel)
        dateLabel.anchor(top: nil, paddingTop: 0, right: nil, paddingRight: 0, left: leftAnchor, paddingLeft: 16, bottom: nil, paddingBottom: 0, width: 0, height: 20)
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
