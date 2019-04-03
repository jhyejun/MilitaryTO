//
//  IndustryDetailViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class IndustryDetailViewController: HJViewController {
    private let tableView: HJTableView = HJTableView().then {
        $0.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: -8)
        $0.separatorStyle = .singleLine
        $0.tableFooterView = UIView()
    }
    private let scrollView: UIScrollView = UIScrollView().then {
        $0.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: -8)
    }
    private let stackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
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
        
        scrollView.addSubview(stackView)
        
        addSubViews(views: [tableView])
        setConstraints()
//        setIndustryData()
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setIndustryData() {
        let wrapperView = UIView()
        let nameLabel: UILabel = UILabel().then {
            $0.text = data?.name
            $0.textColor = .flatBlack
            $0.font = $0.font.withSize(20)
        }
        wrapperView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        
        stackView.addArrangedSubview(wrapperView)
        IndustryKey.cases.forEach { key in
            guard key != .idx else { return }
            
            let view = UIView()
            let keyLabel = UILabel().then {
                $0.text = key.keyString
                $0.numberOfLines = 0
                $0.textColor = .darkGray
                $0.font = $0.font.withSize(15)
            }
            let valueLabel = UILabel().then {
                $0.text = data?.toValue(key: key)
                $0.numberOfLines = 0
                $0.textColor = .flatBlack
                $0.font = $0.font.withSize(17)
            }
            
            view.addSubview(keyLabel)
            view.addSubview(valueLabel)
            
            keyLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().inset(10)
                make.leading.trailing.equalToSuperview().inset(10)
            }
            valueLabel.snp.makeConstraints { (make) in
                make.top.equalTo(keyLabel.snp.bottom).offset(6)
                make.leading.trailing.equalTo(keyLabel)
                make.bottom.equalToSuperview().inset(10)
            }
            
            stackView.addArrangedSubview(view)
        }
    }
}
