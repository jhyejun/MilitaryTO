//
//  FilterViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class FilterViewController<T: Military>: HJViewController {
    private let applyButton: UIButton = UIButton().then {
        $0.setTitle("적용하기", for: .normal)
    }
    
    private var kindUniqueData: [String]?
    private var locationUniqueData: [String]?
    private var totalTOUniqueData: [Int]?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        kindUniqueData = dataDistinct(by: "kind")?.compactMap { $0.kind }
        locationUniqueData = dataDistinct(by: "location")?.compactMap { $0.location }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func dataDistinct(by: String) -> Results<T>? {
        return databaseManager().read(T.self)?.distinct(by: [by])
    }
}
