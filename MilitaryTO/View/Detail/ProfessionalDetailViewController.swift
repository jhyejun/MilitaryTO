//
//  ProfessionalDetailViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class ProfessionalDetailViewController: DetailViewController {
    private var data: Professional?
    
    init(_ data: Professional) {
        super.init(nibName: nil, bundle: nil)
        
        self.data = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
