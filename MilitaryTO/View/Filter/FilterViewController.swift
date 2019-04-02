//
//  FilterViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class FilterViewController: HJViewController {
    private let applyButton: UIButton = UIButton().then {
        $0.setTitle("적용하기", for: .normal)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(20)
        $0.setTitleColor(.flatWhite, for: .normal)
        $0.backgroundColor = .flatBlue
//        $0.setCornerRadius(5)
//        $0.setBorder(color: .flatForestGreenDark, width: 0.5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "필터"
        
        addSubViews(views: [applyButton])
        setConstraints()
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        applyButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
}
