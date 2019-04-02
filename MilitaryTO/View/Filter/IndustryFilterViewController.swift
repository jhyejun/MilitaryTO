//
//  IndustryFilterViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class IndustryFilterViewController: FilterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func industryDistinct(by: String) -> Results<Industry>? {
        return databaseManager().read(Industry.self)?.distinct(by: [by])
    }
}
