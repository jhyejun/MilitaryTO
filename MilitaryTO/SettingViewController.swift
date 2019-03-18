//
//  SettingViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 14/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

enum SettingList: String, CaseIterable {
    case clear_industry_database = "산업기능요원 데이터베이스 초기화"
    case clear_professional_database = "전문연구요원 데이터베이스 초기화"
    case app_version = "앱 버전"
}

class SettingViewController: HJViewController {
    private let tableView: HJTableView = HJTableView().then {
        $0.separatorStyle = .none
    }
    
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
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingTableViewCell()
        cell.titleLabel.text = SettingList.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
