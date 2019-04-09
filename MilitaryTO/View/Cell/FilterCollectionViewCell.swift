//
//  FilterCollectionViewCell.swift
//  MilitaryTO
//
//  Created by 장혜준 on 05/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class FilterCollectionViewCell: UICollectionViewCell {
    private let titleButton: UIButton = UIButton().then {
        $0.setTitleColor(.green, for: .normal)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(17)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleButton)
        
        titleButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(title: String) {
        titleButton.setTitle(title, for: .normal)
    }
}
