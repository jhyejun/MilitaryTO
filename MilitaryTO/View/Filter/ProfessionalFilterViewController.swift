//
//  ProfessionalFilterViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class ProfessionalFilterViewController: FilterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func professionalDistinct(by: String) -> Results<Professional>? {
        return databaseManager().read(Professional.self)?.distinct(by: [by])
    }
}
