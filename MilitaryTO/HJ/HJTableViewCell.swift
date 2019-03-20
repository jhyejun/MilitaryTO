//
//  HJTableViewCell.swift
//  MilitaryTO
//
//  Created by 장혜준 on 15/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class HJTableViewCell: UITableViewCell, SetAutoLayout {
    init(resuseIdentifier: String) {
        super.init(style: .default, reuseIdentifier: resuseIdentifier)
        
        selectionStyle = .none
    }
    
    func addSubViews(views: [UIView]) {
        views.forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func setConstraints() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
