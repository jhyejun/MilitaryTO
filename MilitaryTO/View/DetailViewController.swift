//
//  DetailViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 29/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class DetailViewController<T: Military>: HJViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView: HJTableView = HJTableView().then {
        $0.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: -8)
        $0.separatorStyle = .singleLine
        $0.tableFooterView = UIView()
    }
    
    private var data: T
    private var kind: MilitaryServiceKind
    
    init(_ data: T, _ kind: MilitaryServiceKind) {
        self.data = data
        self.kind = kind
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "상세정보"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubViews(views: [tableView])
        setConstraints()
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    // TableView Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch kind {
        case .Industry:
            return IndustryKey.detailCases.count
        case .Professional:
            return ProfessionalKey.detailCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let nameLabel = UILabel().then {
            $0.text = data.name
            $0.textColor = .flatBlack
            $0.font = $0.font.withSize(28)
        }
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch kind {
        case .Industry:
            let cell = DetailTableViewCell<T, IndustryKey>(key: IndustryKey.detailCases[indexPath.row], data: data, kind: kind)
            cell.updateCell()
            return cell
        case .Professional:
            let cell = DetailTableViewCell<T, ProfessionalKey>(key: ProfessionalKey.detailCases[indexPath.row], data: data, kind: kind)
            cell.updateCell()
            return cell
        }
    }
}
