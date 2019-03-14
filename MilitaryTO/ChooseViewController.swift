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
    private let settingButton: UIButton = UIButton().then {
        $0.setImage(UIImage(imageLiteralResourceName: "icon-setting"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        industryButton.addTarget(self, action: #selector(updateIndustryData(_:)), for: .touchUpInside)
        professionalButton.addTarget(self, action: #selector(updateProfessionalData(_:)), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(didTappedSettingButton(_:)), for: .touchUpInside)
        
        addSubViews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func addSubViews() {
        self.view.addSubview(industryButton)
        self.view.addSubview(professionalButton)
        self.view.addSubview(settingButton)
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
        
        settingButton.snp.makeConstraints { (make) in
            make.topMargin.trailing.equalToSuperview().inset(30)
            make.width.height.equalTo(30)
        }
    }
    
    @objc func updateIndustryData(_ sender: UIButton) {
        startAnimating()
        
        firebaseManager().detectConnectionState { [weak self] result in
            guard let self = self else { return }
            
            if result {
                firebaseManager().request(child: FirebaseChild.version.rawValue) { [weak self] (data: [String: Any]?) in
                    guard let self = self, let data = data else { return }
                    
                    self.syncDatabase(.Industry, data) { [weak self] result in
                        guard let self = self else { return }
                        self.stopAnimating()
                        
                        if result {
                            self.presentList(sender.titleLabel?.text, .Industry)
                        } else {
                            self.presentUpdateFailAlert()
                        }
                    }
                }
            } else {
                self.stopAnimating()
                
                if databaseManager().isNotEmpty(Industry.self) {
                    self.presentList(sender.titleLabel?.text, .Industry)
                } else {
                    self.presentDisconnectAlert()
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
    
    @objc func didTappedSettingButton(_ sender: UIBarButtonItem) {
        let vc = SettingViewController("설정")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func syncDatabase(_ kind: MilitaryServiceKind, _ data: [String: Any], _ completion: @escaping (Bool) -> Void) {
        var key: String = ""
        var databaseIsEmpty: Bool = false
        
        switch kind {
        case .Industry:
            key = FirebaseDatabaseVersion.industry_database_version.rawValue
            databaseIsEmpty = databaseManager().isEmpty(Industry.self)
            
        case .Professional:
            key = FirebaseDatabaseVersion.professional_database_version.rawValue
            databaseIsEmpty = databaseManager().isEmpty(Professional.self)
        }
        
        if let version = data[FirebaseDatabaseVersion.industry_database_version.rawValue] as? Int {
            if firebaseManager().isNeedToUpdateDatabaseVersion(version, key) || databaseIsEmpty {
                firebaseManager().updateDatabase(kind, data, completion)
            } else {
                completion(true)
            }
        } else {
            firebaseManager().updateDatabase(kind, data, completion)
        }
    }
    
    private func presentDisconnectAlert() {
        let alert = AlertBuilder(title: "알림", message: "인터넷 연결이 되어있지 않아\n데이터를 받아올 수 없습니다.").addOk()
        alert.present(parent: self, animated: true, completion: nil)
    }
    
    private func presentUpdateFailAlert() {
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
