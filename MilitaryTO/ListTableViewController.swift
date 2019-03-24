//
//  ListTableViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 26/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class ListTableViewController<T: Object>: HJViewController, UITableViewDelegate, UITableViewDataSource {
    private let tableView: HJTableView = HJTableView().then {
        $0.separatorStyle = .none
    }
    
    private var data: [T]? = []
    private var kind: MilitaryServiceKind?

    init(_ title: String? = nil, _ kind: MilitaryServiceKind) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = title
        self.data = databaseManager().read(T.self)?.compactMap { $0 as T }
        self.kind = kind
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
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // TableView Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListTableViewCell<T>(data: data?[indexPath.row], kind: kind)
        cell.updateCell()
        
        return cell
    }
}
