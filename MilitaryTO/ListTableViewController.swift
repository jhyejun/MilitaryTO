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

    init(_ title: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
    }
}
