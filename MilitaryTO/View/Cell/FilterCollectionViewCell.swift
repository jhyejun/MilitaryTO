//
//  FilterCollectionViewCell.swift
//  MilitaryTO
//
//  Created by 장혜준 on 05/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

protocol FilterCollectionViewCellDelegate {
    func didTouchedTitleButton(_ sender: UIButton, _ filterKind: String)
}

class FilterCollectionViewCell: UICollectionViewCell {
    private let titleButton: UIButton = UIButton().then {
        $0.setTitleColor(.flatBlack, for: .normal)
        $0.setTitleColor(.flatWhite, for: .selected)
        $0.setBorder(color: .flatBlue, width: 0.5)
        $0.setCornerRadius(5)
        $0.backgroundColor = .white
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(15)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    private var buttonIsSelected: Bool {
        get {
            return titleButton.isSelected
        }
        set {
            titleButton.isSelected = newValue
            updateTitleButton()
        }
    }
    
    private var filterKey: String?
    var delegate: FilterCollectionViewCellDelegate?
    
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
    
    func update(title: String, filterKey: String, selected: Bool) {
        titleButton.setTitle(title, for: .normal)
        buttonIsSelected = selected
        self.filterKey = filterKey
    }
    
    @objc private func touchedTitleButton(_ sender: UIButton) {
        buttonIsSelected = !titleButton.isSelected
        delegate?.didTouchedTitleButton(sender, filterKey ?? "none")
    }
    
    func updateTitleButton() {
        if buttonIsSelected {
            titleButton.backgroundColor = .flatBlue
            titleButton.setBorder(color: .flatBlack, width: 0.5)
        } else {
            titleButton.backgroundColor = .white
            titleButton.setBorder(color: .flatBlue, width: 0.5)
        }
    }
}
