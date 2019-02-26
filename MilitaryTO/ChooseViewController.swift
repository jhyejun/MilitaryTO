//
//  ChooseViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 20/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit
import TransitionButton
import Firebase
import FirebaseAnalytics

enum MilitaryServiceKind: String {
    case Industry
    case Professional
}

class ChooseViewController: UIViewController {
    private let industryButton: TransitionButton = TransitionButton().then {
        $0.setTitle("산업기능요원", for: .normal)
        $0.backgroundColor = UIColor.flatBlue
    }
    private let professionalButton: TransitionButton = TransitionButton().then {
        $0.setTitle("전문연구요원", for: .normal)
        $0.backgroundColor = UIColor.flatRed
    }
//    private var ref: DatabaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .flatWhite
        
        industryButton.addTarget(self, action: #selector(presentList(_:)), for: .touchUpInside)
        professionalButton.addTarget(self, action: #selector(presentList(_:)), for: .touchUpInside)
        
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
            make.centerX.equalTo(self.industryButton)
            make.centerY.equalToSuperview().offset(100)
            make.width.height.equalTo(self.industryButton)
        }
    }
    
    @objc func presentList(_ sender: TransitionButton) {
        sender.startAnimation()
        
        sender.stopAnimation(animationStyle: .expand) {
            let vc = ListTableViewController()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
