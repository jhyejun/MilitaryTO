//
//  ListTableViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 26/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class ListTableViewController: HJViewController {
    private let tableView: HJTableView = HJTableView().then {
        $0.separatorStyle = .none
    }
    private var data: Results<Object>?

    init(_ title: String? = nil, _ kind: MilitaryServiceKind) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = title
        
        switch kind {
        case .Industry:
            databaseManager().read(Industry.self)
        case .Professional:
            databaseManager().read(Professional.self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
    }
}
