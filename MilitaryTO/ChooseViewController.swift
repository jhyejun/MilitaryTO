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
    case Industry = "산업기능요원"
    case Professional = "전문연구요원"
}

class ChooseViewController: HJViewController {
    private let industryButton: UIButton = UIButton().then {
        $0.setTitle(MilitaryServiceKind.Industry.rawValue, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setBorder(color: .flatRed, width: 0.5)
        $0.setCornerRadius(10)
    }
    private let professionalButton: UIButton = UIButton().then {
        $0.isEnabled = false
        $0.setTitle(MilitaryServiceKind.Professional.rawValue, for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setBorder(color: .flatBlue, width: 0.5)
        $0.setCornerRadius(10)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(industryButton)
        self.view.addSubview(professionalButton)
        
        industryButton.addTarget(self, action: #selector(updateIndustryData(_:)), for: .touchUpInside)
        professionalButton.addTarget(self, action: #selector(updateProfessionalData(_:)), for: .touchUpInside)
        
        setConstraints()
        
        databaseManager().deleteAll()
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
        startAnimating()
        firebaseManager().request(child: FirebaseChild.version.rawValue) { [weak self] (data: [String: Any]?) in
            guard let self = self, let data = data else { return }
            
            self.syncDatabase(.Industry, data) { [weak self] result in
                guard let self = self else { return }
                self.stopAnimating()
                
                if result {
                    self.presentList(sender.titleLabel?.text, .Industry)
                } else {
                    
                }
                
            }
        }
    }
    
    @objc func updateProfessionalData(_ sender: UIButton) {
        startAnimating()
        firebaseManager().request(child: FirebaseChild.version.rawValue) { [weak self] (data: [String: Any]?) in
            guard let self = self, let data = data else { return }
            
            self.syncDatabase(.Professional, data) { [weak self] result in
                guard let self = self else { return }
                self.stopAnimating()
                
                if result {
                    self.presentList(sender.titleLabel?.text, .Professional)
                } else {
                    
                }
            }
        }
    }
    
    private func syncDatabase(_ kind: MilitaryServiceKind, _ data: [String: Any], _ completion: @escaping (Bool) -> Void) {
        var key: String = ""
        
        switch kind {
        case .Industry:
            key = FirebaseDatabaseVersion.industry_database_version.rawValue
            
        case .Professional:
            key = FirebaseDatabaseVersion.professional_database_version.rawValue
        }
        
        if let version = data[FirebaseDatabaseVersion.industry_database_version.rawValue] as? Float {
            if firebaseManager().isNeedToUpdateDatabaseVersion(version, key) {
                firebaseManager().updateDatabase(kind, data, completion)
            }
        } else {
            firebaseManager().updateDatabase(kind, data, completion)
        }
    }
    
    private func presentList(_ title: String?, _ kind: MilitaryServiceKind) {
        let vc = ListTableViewController(title, kind)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
