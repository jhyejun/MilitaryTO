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
                    self.presentFailAlert()
                }
                
            }
        }
    }
    
    @objc func updateProfessionalData(_ sender: UIButton) {
        let alert = AlertBuilder(title: "알림", message: "전문연구요원은\n데이터가 준비되어 있지 않습니다.\n추후 업데이트 예정입니다.").addOk()
        alert.present(parent: self, animated: true, completion: nil)
        
//        startAnimating()
//        firebaseManager().request(child: FirebaseChild.version.rawValue) { [weak self] (data: [String: Any]?) in
//            guard let self = self, let data = data else { return }
//
//            self.syncDatabase(.Professional, data) { [weak self] result in
//                guard let self = self else { return }
//                self.stopAnimating()
//
//                if result {
//                    self.presentList(sender.titleLabel?.text, .Professional)
//                } else {
//                    self.presentFailAlert()
//                }
//            }
//        }
    }
    
    private func syncDatabase(_ kind: MilitaryServiceKind, _ data: [String: Any], _ completion: @escaping (Bool) -> Void) {
        var key: String = ""
        
        switch kind {
        case .Industry:
            key = FirebaseDatabaseVersion.industry_database_version.rawValue
            
        case .Professional:
            key = FirebaseDatabaseVersion.professional_database_version.rawValue
        }
        
        if let version = data[FirebaseDatabaseVersion.industry_database_version.rawValue] as? Int {
            if firebaseManager().isNeedToUpdateDatabaseVersion(version, key) {
                firebaseManager().updateDatabase(kind, data, completion)
            } else {
                completion(true)
            }
        } else {
            firebaseManager().updateDatabase(kind, data, completion)
        }
    }
    
    private func presentFailAlert() {
        let alert = AlertBuilder(title: "알림", message: "데이터 업데이트를 실패하였습니다.").addOk()
        alert.present(parent: self, animated: true, completion: nil)
    }
    
    private func presentList(_ title: String?, _ kind: MilitaryServiceKind) {
        switch kind {
        case .Industry:
            let vc = ListTableViewController<Industry>(title, kind)
            self.navigationController?.pushViewController(vc, animated: true)
        case .Professional:
            let vc = ListTableViewController<Professional>(title, kind)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
