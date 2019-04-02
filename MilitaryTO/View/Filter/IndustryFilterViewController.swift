//
//  IndustryFilterViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class IndustryFilterViewController: FilterViewController {
    private let kindStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
    }
    
    private var kindUniqueData: [String]?
    private var locationUniqueData: [String]?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        kindUniqueData = industryDistinct(by: "kind")?.compactMap { $0.kind }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func industryDistinct(by: String) -> Results<Industry>? {
        return databaseManager().read(Industry.self)?.distinct(by: [by])
    }
}
