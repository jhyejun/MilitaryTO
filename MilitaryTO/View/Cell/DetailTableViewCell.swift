//
//  DetailTableViewCell.swift
//  MilitaryTO
//
//  Created by 장혜준 on 03/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class DetailTableViewCell<T: Military, K>: HJTableViewCell, UpdatableTableViewCell, SetAutoLayout {
    private let keyLabel: UILabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = $0.font.withSize(15)
    }
    private let valueLabel: UILabel = UILabel().then {
        $0.textColor = .flatBlack
        $0.font = $0.font.withSize(17)
    }
    
    private var key: K
    private var data: T
    private var kind: MilitaryServiceKind
    
    init(key: K, data: T, kind: MilitaryServiceKind) {
        self.key = key
        self.data = data
        self.kind = kind
        
        super.init(resuseIdentifier: DetailTableViewCell.className)
        
        separatorInset = .zero
        
        addSubViews(views: [keyLabel, valueLabel])
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        keyLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(keyLabel.snp.bottom).offset(6)
            make.leading.trailing.equalTo(keyLabel)
        }
    }
    
    func updateCell() {
        switch kind {
        case .Industry:
            guard let data = self.data as? Industry, let key = self.key as? IndustryKey else { return }
            valueLabel.text = data.toValue(key: key)
        case .Professional:
            guard let data = self.data as? Professional, let key = self.key as? ProfessionalKey else { return }
            valueLabel.text = data.toValue(key: key)
        }
    }
}
