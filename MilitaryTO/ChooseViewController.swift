//
//  ChooseViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 20/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class ChooseViewController: UIViewController {
    private let industryButton: UIButton = UIButton().then {
        $0.setTitle("산업기능요원", for: .normal)
        $0.backgroundColor = UIColor.flatBlue
    }
    private let professionalButton: UIButton = UIButton().then {
        $0.setTitle("전문연구요원", for: .normal)
        $0.backgroundColor = UIColor.flatRed
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.flatGreen
        
        self.view.addSubview(industryButton)
        self.view.addSubview(professionalButton)
        
        self.setConstraints()
    }
    
    func setConstraints() {
        industryButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
            make.width.equalTo(270)
            make.height.equalTo(70)
        }
        
        professionalButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.industryButton).offset(100)
            make.centerX.equalTo(self.industryButton)
            make.width.height.equalTo(self.industryButton)
        }
    }
}
