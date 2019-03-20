//
//  ListTableViewCell.swift
//  MilitaryTO
//
//  Created by 장혜준 on 15/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class ListTableViewCell: HJTableViewCell {
    static let REUSE_ID: String = ListTableViewCell.className
    
    init() {
        super.init(resuseIdentifier: ListTableViewCell.REUSE_ID)
        
        setConstraints()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
