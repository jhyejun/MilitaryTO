//
//  DetailViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 29/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class DetailViewController<T: Military>: HJViewController {
    private let tableView: HJTableView = HJTableView().then {
        $0.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: -8)
        $0.separatorStyle = .singleLine
        $0.tableFooterView = UIView()
    }
    
    private var data: T?
    
    init(_ data: T?) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = "상세정보"
        self.data = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews(views: [tableView])
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
