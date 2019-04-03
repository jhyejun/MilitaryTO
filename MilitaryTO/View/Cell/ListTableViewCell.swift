//
//  ListTableViewCell.swift
//  MilitaryTO
//
//  Created by 장혜준 on 15/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class ListTableViewCell<T: Military>: HJTableViewCell, UpdatableTableViewCell, SetAutoLayout {
    private let nameLabel: UILabel = UILabel().then {
        $0.textColor = .flatBlack
        $0.font = $0.font.withSize(17)
    }
    private let kindLabel: UILabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = $0.font.withSize(15)
    }
    private let locationLabel: UILabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = $0.font.withSize(15)
    }
    private let totalTOLabel: UILabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = $0.font.withSize(15)
    }
    
    private var data: T
    private var kind: MilitaryServiceKind
    
    init(data: T, kind: MilitaryServiceKind) {
        self.data = data
        self.kind = kind
        
        super.init(resuseIdentifier: ListTableViewCell.className)
        
        separatorInset = .zero
        accessoryType = .disclosureIndicator
        
        addSubViews(views: [nameLabel, kindLabel, locationLabel, totalTOLabel])
        setConstraints()
    }
    
    func setConstraints() {
        nameLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        kindLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.trailing.equalTo(nameLabel)
        }
        
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(kindLabel.snp.bottom).offset(3)
            make.leading.trailing.equalTo(kindLabel)
        }
        
        totalTOLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationLabel.snp.bottom).offset(3)
            make.leading.trailing.equalTo(locationLabel)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell() {
        switch kind {
        case .Industry:
            guard let data = self.data as? Industry else { return }
            nameLabel.text = data.name ?? ""
            kindLabel.text = "업종 : \(data.kind ?? "알 수 없음")"
            locationLabel.text = "소재지 : \(data.location ?? "알 수 없음")"
            totalTOLabel.text = "총 배정인원(현역) : \(String(data.totalTO))"
        case .Professional:
            nameLabel.text = data.name
            kindLabel.text = "업종 : \(data.kind ?? "알 수 없음")"
            locationLabel.text = "소재지 : \(data.location ?? "알 수 없음")"
            totalTOLabel.isHidden = true
        }
    }
}
