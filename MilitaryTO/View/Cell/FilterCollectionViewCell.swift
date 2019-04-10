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
        $0.setTitleColor(.black, for: .normal)
        $0.setBorder(color: .blue, width: 0.5)
        $0.setCornerRadius(5)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(17)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleButton.addTarget(self, action: #selector(touchedTitleButton(_:)), for: .touchUpInside)
        
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
    
    func updateStatus() {
        titleButton.isSelected = !titleButton.isSelected
        
        
    }
    
    @objc private func touchedTitleButton(_ sender: UIButton) {
        titleButton.isSelected = !titleButton.isSelected
    }
}
