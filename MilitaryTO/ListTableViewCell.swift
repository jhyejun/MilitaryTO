//
//  ListTableViewCell.swift
//  MilitaryTO
//
//  Created by 장혜준 on 15/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class ListTableViewCell<T: Object>: HJTableViewCell, UpdatableTableViewCell, SetAutoLayout {
    private let titleLabel: UILabel = UILabel().then {
        $0.textColor = .flatBlack
        $0.font = $0.font.withSize(17)
    }
    
    private var data: T?
    
    init(data: T?) {
        super.init(resuseIdentifier: ListTableViewCell.className)
        
        self.data = data
        
        addSubViews(views: [titleLabel])
        setConstraints()
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell() {
        
    }
}
