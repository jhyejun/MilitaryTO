//
//  SettingViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 14/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import Carte
import StoreKit
import MessageUI

enum SettingList: String, CaseIterable {
    case clear_industry_database = "산업기능요원 데이터 초기화"
    case clear_professional_database = "전문연구요원 데이터 초기화"
    case app_store_review = "앱 스토어 리뷰 남기기"
    case email_to_developer = "개발자에게 문의하기"
    case opensource_license = "오픈소스 라이센스"
    case app_version = "버전"
    
    var isClear: Bool {
        switch self {
        case .clear_industry_database, .clear_professional_database:
            return true
        default:
            return false
        }
    }
    
    var descText: String? {
        switch self {
        case .app_version:
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        default:
            return nil
        }
    }
}

class SettingViewController: HJViewController, MFMailComposeViewControllerDelegate {
    private let tableView: HJTableView = HJTableView().then {
        $0.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: -8)
        $0.separatorStyle = .none
        $0.tableFooterView = UIView()
    }
    
    private let headerItems: [String] = ["데이터", "리뷰", "병티확"]
    private let items: [[SettingList]] = [[.clear_industry_database, .clear_professional_database],
                                          [.app_store_review, .email_to_developer],
                                          [.opensource_license, .app_version]]
    
    init(_ title: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubViews(views: [tableView])
        setConstraints()
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func requestReview(appId: String) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            guard let url = URL(string: "itms-apps://itunes.apple.com/app/" + appId) else { return }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.mailComposeDelegate = self
            vc.setToRecipients(["hyejun417@gmail.com"])
            vc.setSubject("")
            vc.setMessageBody("", isHTML: false)
            
            self.present(vc, animated: true, completion: nil)
        } else {
            let vc = AlertBuilder(title: "알림", message: "메일을 보낼 수 없습니다.").addOk()
            
            self.present(builder: vc)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerTitleLabel = UILabel().then {
            $0.text = headerItems[section]
            $0.textColor = .lightGray
            $0.font = $0.font.withSize(15)
        }
        
        headerView.addSubview(headerTitleLabel)
        
        headerTitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(5)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTableViewCell(data: items[indexPath.section][indexPath.row])
        cell.updateCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section][indexPath.row]
        if item.isClear {
            let vc = AlertBuilder(title: "알림", message: "데이터가 초기화 됩니다.\n데이터를 초기화 하시겠습니까?")
            vc.addOk {
                if item == .clear_industry_database {
                    databaseManager().industryObjectDelete()
                } else {
                    databaseManager().professionalObjectDelete()
                }
            }
            vc.addCancel()
            
            self.present(builder: vc)
        } else if item == .app_store_review {
            requestReview(appId: "1441425450")
        } else if item == .email_to_developer {
            sendEmail()
        } else if item == .opensource_license {
            let vc = CarteViewController()
            self.push(viewController: vc)
        }
    }
}
