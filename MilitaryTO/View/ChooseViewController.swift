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

    let dpBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        industryButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.updateDatabase(.Industry, self?.industryButton.titleLabel?.text)
            }).disposed(by: dpBag)

        professionalButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let alert = AlertBuilder(title: "알림", message: "전문연구요원은\n데이터가 준비되어 있지 않습니다.\n추후 업데이트 예정입니다.").addOk()
                self?.present(builder: alert)
            }).disposed(by: dpBag)

        settingButton.rx.tap
            .subscribe(onNext: { [weak self] in
                let vc = SettingViewController("설정")
                self?.push(viewController: vc)
            }).disposed(by: dpBag)

        addSubViews(views: [industryButton, professionalButton, settingButton])
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.isHidden = true
    }

    override func setConstraints() {
        super.setConstraints()

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


    private func updateDatabase(_ kind: MilitaryServiceKind, _ title: String?) {
        firebaseManager().detectConnectionState { [weak self] result in
            if result {
                self?.startAnimating()

                firebaseManager().request(child: FirebaseChild.version.rawValue) { [weak self] (data: [String: Any]?) in
                    guard let data = data else { return }

                    self?.syncDatabase(kind, data) { [weak self] result in
                        self?.stopAnimating()

                        if result {
                            self?.presentList(kind, title)
                        } else {
                            self?.presentUpdateFailAlert()
                        }
                    }
                }
            } else {
                var dataType: Military.Type

                switch kind {
                case .Industry:
                    dataType = Industry.self
                case .Professional:
                    dataType = Professional.self
                }

                if databaseManager().isNotEmpty(dataType) {
                    self?.presentList(kind, title)
                } else {
                    self?.presentDisconnectAlert()
                }
            }
        }
    }

    private func syncDatabase(_ kind: MilitaryServiceKind, _ data: [String: Any], _ completion: @escaping (Bool) -> Void) {
        let key: String
        let databaseIsEmpty: Bool

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
//                alertUpdateDatabase(kind: kind, storage: "3MB") { [weak self] in
//                    guard let self = self else { return }
//                    self.startAnimating()
//                    firebaseManager().updateDatabase(kind, data, completion)
//                }
            } else {
                completion(true)
            }
        } else {
            firebaseManager().updateDatabase(kind, data, completion)
//            alertUpdateDatabase(kind: kind, storage: "3MB") { [weak self] in
//                guard let self = self else { return }
//                self.startAnimating()
//                firebaseManager().updateDatabase(kind, data, completion)
//            }
        }
    }

    private func alertUpdateDatabase(kind: MilitaryServiceKind, storage: String, closure: @escaping () -> Void) {
        let alert = AlertBuilder(title: "알림", message: "\(kind.rawValue) 데이터(\(storage))를\n받아오시겠습니까?", cancellable: true).addOk {
            closure()
        }
        present(builder: alert)
    }


    private func presentDisconnectAlert() {
        let alert = AlertBuilder(title: "알림", message: "인터넷 연결이 되어있지 않아\n데이터를 받아올 수 없습니다.").addOk()
        alert.present(parent: self, animated: true, completion: nil)
    }

    private func presentUpdateFailAlert() {
        let alert = AlertBuilder(title: "알림", message: "데이터 업데이트를 실패하였습니다.").addOk()
        alert.present(parent: self, animated: true, completion: nil)
    }


    private func presentList(_ kind: MilitaryServiceKind, _ title: String?) {
        switch kind {
        case .Industry:
            let vc = ListTableViewController<Industry>(title, kind)
            self.push(viewController: vc)
        case .Professional:
            let vc = ListTableViewController<Professional>(title, kind)
            self.push(viewController: vc)
        }
    }
}
