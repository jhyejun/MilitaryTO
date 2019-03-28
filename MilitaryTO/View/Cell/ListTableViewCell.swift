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
        $0.backgroundColor = .black
        $0.textColor = .flatBlack
        $0.font = $0.font.withSize(17)
    }
    private let totalTOLabel: UILabel = UILabel().then {
        $0.backgroundColor = .red
        $0.textColor = .flatBlack
        $0.font = $0.font.withSize(17)
    }
    private let arrowLabel: UILabel = UILabel().then {
        $0.backgroundColor = .blue
        $0.text = ">"
        $0.textColor = .flatBlack
        $0.font = $0.font.withSize(17)
    }
    
    private var data: T?
    private var kind: MilitaryServiceKind?
    
    init(data: T?, kind: MilitaryServiceKind?) {
        super.init(resuseIdentifier: ListTableViewCell.className)
        
        self.data = data
        self.kind = kind
        
        addSubViews(views: [nameLabel, totalTOLabel, arrowLabel])
        setConstraints()
    }
    
    func setConstraints() {
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        totalTOLabel.setContentHuggingPriority(.init(800), for: .horizontal)
        totalTOLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
        }
        
        arrowLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(totalTOLabel)
            make.leading.equalTo(totalTOLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
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
//            nameLabel.text = data.name
            nameLabel.text = "TESTccccccccccccccccccccccccccccccccccccccccccccccccccc"
            totalTOLabel.text = String(data.totalTO)
        case .Professional:
            nameLabel.text = data?.name
        }
    }
}
