//
//  FilterViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class FilterViewController<T: Military>: HJViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView: HJTableView = HJTableView().then {
        $0.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: -8)
        $0.separatorStyle = .singleLine
        $0.tableFooterView = UIView()
    }
    private let applyButton: UIButton = UIButton().then {
        $0.setTitle("적용하기", for: .normal)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(20)
        $0.setTitleColor(.flatWhite, for: .normal)
        $0.backgroundColor = .flatForestGreenDark
        $0.contentVerticalAlignment = .top
        $0.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    private var data: [[String]]?
    private var kind: MilitaryServiceKind
    
    init(kind: MilitaryServiceKind) {
        self.kind = kind
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "필터"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubViews(views: [tableView, applyButton])
        setConstraints()
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        tableView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalTo(tableView)
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    func dataDistinct(by: String) -> Results<T>? {
        return databaseManager().read(T.self)?.distinct(by: [by])
    }
    
    
    // TableView Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        switch kind {
        case .Industry:
            return IndustryKey.filterCases.count
        case .Professional:
            return ProfessionalKey.filterCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch kind {
        case .Industry:
            return IndustryKey.filterCases.count
        case .Professional:
            return ProfessionalKey.filterCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        let nameLabel = UILabel().then {
//            $0.text = data.name
//            $0.textColor = .flatBlack
//            $0.font = $0.font.withSize(28)
//        }
//
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.addSubview(nameLabel)
//        nameLabel.snp.makeConstraints { (make) in
//            make.top.leading.trailing.equalToSuperview().inset(10)
//            make.bottom.equalToSuperview()
//        }
//
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch kind {
//        case .Industry:
//            let cell = DetailTableViewCell<T, IndustryKey>(key: IndustryKey.detailCases[indexPath.row], data: data, kind: kind)
//            cell.updateCell()
//            return cell
//        case .Professional:
//            let cell = DetailTableViewCell<T, ProfessionalKey>(key: ProfessionalKey.detailCases[indexPath.row], data: data, kind: kind)
//            cell.updateCell()
//            return cell
//        }
        return UITableViewCell()
    }
}
