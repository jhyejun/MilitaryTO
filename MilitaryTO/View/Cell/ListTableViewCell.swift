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
    private let totalTOLabel: UILabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = $0.font.withSize(15)
    }
    
    private var data: T?
    private var kind: MilitaryServiceKind?
    
    init(data: T?, kind: MilitaryServiceKind?) {
        super.init(resuseIdentifier: ListTableViewCell.className)
        
        self.data = data
        self.kind = kind
        
        separatorInset = .zero
        accessoryType = .disclosureIndicator
        
        addSubViews(views: [nameLabel, totalTOLabel])
        setConstraints()
    }
    
    func setConstraints() {
        nameLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(10)
        }
        
        totalTOLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.trailing.equalTo(nameLabel)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell() {
        guard let safeKind = kind else { return }
        
        switch safeKind {
        case .Industry:
            guard let data = self.data as? Industry else { return }
            nameLabel.text = data.name
            totalTOLabel.text = "총 배정인원(현역) : \(String(data.totalTO))"
        case .Professional:
            nameLabel.text = data?.name
        }
    }
}
