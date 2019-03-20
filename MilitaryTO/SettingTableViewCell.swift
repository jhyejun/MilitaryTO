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
        $0.font = $0.font.withSize(17)
    }
    let descLabel: UILabel = UILabel().then {
        $0.isHidden = true
        $0.textColor = .black
        $0.font = $0.font.withSize(17)
    }
    let arrowImageView: UIImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "icon-arrow.png")
    }
    
    init() {
        super.init(resuseIdentifier: SettingTableViewCell.REUSE_ID)
        
        addSubViews(views: [titleLabel, descLabel, arrowImageView])
        setConstraints()
    }
    
    override func setConstraints() {
        super.setConstraints()
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
