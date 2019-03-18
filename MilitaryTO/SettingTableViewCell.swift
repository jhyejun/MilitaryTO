//
//  SettingTableViewCell.swift
//  MilitaryTO
//
//  Created by 장혜준 on 15/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class SettingTableViewCell: HJTableViewCell {
    static let REUSE_ID: String = SettingTableViewCell.className
    
    let titleLabel: UILabel = UILabel().then {
        $0.textColor = .flatBlack
        $0.font = $0.font.withSize(15)
    }
    
    init() {
        super.init(resuseIdentifier: SettingTableViewCell.REUSE_ID)
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
