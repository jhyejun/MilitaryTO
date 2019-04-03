//
//  SettingTableViewCell.swift
//  MilitaryTO
//
//  Created by 장혜준 on 15/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class SettingTableViewCell: HJTableViewCell, UpdatableTableViewCell, SetAutoLayout {
    private let titleLabel: UILabel = UILabel().then {
        $0.textColor = .flatBlack
        $0.font = $0.font.withSize(17)
    }
    private let descLabel: UILabel = UILabel().then {
        $0.isHidden = true
        $0.textColor = .black
        $0.font = $0.font.withSize(17)
    }
    
    private var data: SettingList
    
    init(data: SettingList) {
        self.data = data
        
        super.init(resuseIdentifier: SettingTableViewCell.className)
        
        separatorInset = .zero
        accessoryType = .disclosureIndicator
        
        addSubViews(views: [titleLabel, descLabel])
        setConstraints()
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleLabel)
            make.trailingMargin.equalToSuperview().inset(10)
        }
    }
    
    func updateCell() {
        titleLabel.text = data.rawValue
        
        if data == .app_version {
            descLabel.isHidden = false
            accessoryType = .none
            descLabel.text = data.descText
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
