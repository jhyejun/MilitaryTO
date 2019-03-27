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
    private var kind: MilitaryServiceKind?
    
    init(data: T?, kind: MilitaryServiceKind?) {
        super.init(resuseIdentifier: ListTableViewCell.className)
        
        self.data = data
        self.kind = kind
        
        addSubViews(views: [titleLabel])
        setConstraints()
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell() {
        guard let safeKind = kind else { return }
        
        switch safeKind {
        case .Industry:
            guard let industryData = data as? Industry else { return }
            titleLabel.text = industryData.name
        case .Professional:
            guard let professionalData = data as? Professional else { return }
            titleLabel.text = professionalData.className
        }
    }
}
