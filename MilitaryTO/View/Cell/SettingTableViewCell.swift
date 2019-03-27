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
    private let arrowImageView: UIImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "icon-arrow.png")
    }
    
    private var data: SettingList
    
    init(data: SettingList) {
        self.data = data
        
        super.init(resuseIdentifier: SettingTableViewCell.className)
        
        addSubViews(views: [titleLabel, descLabel, arrowImageView])
        setConstraints()
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(30)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.titleLabel)
            make.trailing.equalToSuperview().inset(30)
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.descLabel)
            make.trailing.equalTo(self.descLabel)
            make.width.height.equalTo(15)
        }
    }
    
    func updateCell() {
        titleLabel.text = data.rawValue
        
        if let text = data.descText {
            descLabel.isHidden = false
            arrowImageView.isHidden = true
            descLabel.text = text
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
