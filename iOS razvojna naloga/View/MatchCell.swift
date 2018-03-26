//
//  MatchCell.swift
//  iOS razvojna naloga
//
//  Created by Alen Kirm on 26. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class MatchCell : UITableViewCell {
    
    let nameLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14)
        l.textColor = UIColor.lightGray
        return l
    }()
    
    let valueLabel : UITextField = {
       let tf = UITextField()
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        return tf
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(nameLabel)
        nameLabel.anchor(top: nil, paddingTop: 0, right: nil, paddingRight: 0, left: leftAnchor, paddingLeft: 16, bottom: nil, paddingBottom: 0, width: 0, height: 0)
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(valueLabel)
        valueLabel.anchor(top: nil, paddingTop: 0, right: rightAnchor, paddingRight: 16, left: nameLabel.rightAnchor, paddingLeft: 8, bottom: nil, paddingBottom: 0, width: 0, height: 0)
        valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
//        layoutSubviews()
        
        valueLabel.setContentHuggingPriority(.init(250), for: .horizontal)
        nameLabel.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
