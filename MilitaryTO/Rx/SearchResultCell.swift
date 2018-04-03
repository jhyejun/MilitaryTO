//
//  SearchResultCell.swift
//  MilitaryTO
//
//  Created by 장혜준 on 2018. 2. 13..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    
    // UI

    let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
         $0.textColor = .black
        //  $0.text = "hi"
    }
    
    let toLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .red
        $0.text = "10"
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(toLabel)
        
        self.nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
        
        self.toLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
