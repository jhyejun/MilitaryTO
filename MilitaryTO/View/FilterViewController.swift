//
//  FilterViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class FilterViewController<T: Military>: HJViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.allowsSelection = false
    }
    private let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    
    private let applyButton: UIButton = UIButton().then {
        $0.setTitle("적용하기", for: .normal)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(20)
        $0.setTitleColor(.flatWhite, for: .normal)
        $0.backgroundColor = .flatForestGreenDark
        $0.contentVerticalAlignment = .top
        $0.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    private var data: [[String]] = [[]]
    private var kind: MilitaryServiceKind
    
    init(kind: MilitaryServiceKind) {
        self.kind = kind
        
        super.init(nibName: nil, bundle: nil)
        
        switch kind {
        case .Industry:
            setIndustryData()
        case .Professional:
            setProfessionalData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "필터"
        
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.className)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubViews(views: [collectionView, applyButton])
        setConstraints()
    }
    
    override func setConstraints() {
        super.setConstraints()

        collectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalTo(collectionView)
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
    }
    
    private func setIndustryData() {
        let kindList: [String] = dataDistinct(by: "kind")?.compactMap { $0.kind } ?? []
        let regionList: [String] = dataDistinct(by: "region")?.compactMap { $0.region } ?? []
//        let totalTOList: [String] = databaseManager().read
        
        data.append(kindList)
        data.append(regionList)
    }
    
    private func setProfessionalData() {
        let kindList: [String] = dataDistinct(by: "kind")?.compactMap { $0.kind } ?? []
        let regionList: [String] = dataDistinct(by: "region")?.compactMap { $0.region } ?? []
//        let totalTOList: [String] = databaseManager().read
        
        data.append(kindList)
        data.append(regionList)
    }
    
    private func dataDistinct(by: String) -> Results<T>? {
        return databaseManager().read(T.self)?.distinct(by: [by])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch kind {
        case .Industry:
            return IndustryKey.filterCases.count
        case .Professional:
            return ProfessionalKey.filterCases.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch kind {
//        case .Industry:
//            return IndustryKey.filterCases.count
//        case .Professional:
//            return ProfessionalKey.filterCases.count
//        }
        return data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.className, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
        cell.update(title: "TEST")
        
        return cell
    }
}
