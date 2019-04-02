//
//  IndustryDetailViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class IndustryDetailViewController: DetailViewController {
    private let stackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    private var data: Industry?
    
    init(_ data: Industry) {
        super.init(nibName: nil, bundle: nil)
        
        self.data = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameLabel: UILabel = UILabel().then {
            $0.text = data?.name
            $0.textColor = .flatBlack
            $0.font = $0.font.withSize(20)
        }
        
        stackView.addArrangedSubview(nameLabel)
        IndustryKey.cases.forEach { key in
            let view = UIView()
            let descriptionLabel = UILabel().then {
                $0.text = key.keyString
            }
        }
    }
}
