//
//  ChooseViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 20/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit
import FirebaseDatabase

enum MilitaryServiceKind: String {
    case industry
    case professional
}

class ChooseViewController: HJViewController {
    private let industryButton: UIButton = UIButton().then {
        $0.setTitle("산업기능요원", for: .normal)
        $0.backgroundColor = UIColor.flatBlue
        $0.setCornerRadius(10)
    }
    private let professionalButton: UIButton = UIButton().then {
        $0.setTitle("전문연구요원", for: .normal)
        $0.backgroundColor = UIColor.flatRed
        $0.setCornerRadius(10)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .flatWhite
        self.view.addSubview(industryButton)
        self.view.addSubview(professionalButton)
        
        industryButton.addTarget(self, action: #selector(updateIndustryData(_:)), for: .touchUpInside)
        professionalButton.addTarget(self, action: #selector(updateProfessionalData(_:)), for: .touchUpInside)
        
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setConstraints() {
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
    
    @objc func updateIndustryData(_ sender: UIButton) {
        let ref: DatabaseReference = Database.database().reference()
        
        ref.child("version").observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            guard let self = self, let data = snapshot.value as? [String: Any] else { return }
            
            if let databaseVersion = data["database_current_version"] as? Int {
                if databaseVersion > myUserDefaults.integer(forKey: "database_version") {
                    myUserDefaults.set(databaseVersion, forKey: "database_version")
                } else {
                    self.presentList(sender.titleLabel?.text, .industry)
                }
            }
        }) { [weak self] (error) in
            guard let self = self else { return }
        }
    }
    
    @objc func updateProfessionalData(_ sender: UIButton) {
        presentList(sender.titleLabel?.text, .professional)
    }
    
    private func presentList(_ title: String?, _ kind: MilitaryServiceKind) {
        let vc = ListTableViewController(title)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
