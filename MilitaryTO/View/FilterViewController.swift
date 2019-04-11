//
//  FilterViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 02/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import AlignedCollectionViewFlowLayout

protocol FilterViewControllerDelegate {
    func apply(filter: [String: Set<String>])
}

class FilterViewController<T: Military>: HJViewController, UICollectionViewDelegate, UICollectionViewDataSource, FilterCollectionViewCellDelegate {
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .white
        $0.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    private let layout: AlignedCollectionViewFlowLayout  = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .center).then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 5
        $0.minimumLineSpacing = 5
        $0.estimatedItemSize = CGSize(width: 40, height: 20)
        $0.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 40, right: 10)
    }
    private let applyButton: UIButton = UIButton().then {
        $0.setTitle("적용하기", for: .normal)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(20)
        $0.setTitleColor(.flatWhite, for: .normal)
        $0.backgroundColor = .flatForestGreenDark
        $0.contentVerticalAlignment = .top
        $0.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    private var data: [[String]] = []
    private var kind: MilitaryServiceKind
    
    private var filterKeyList: [Filter] = []
    private var filterList: [String: Set<String>] = [:]
    
    var delegate: FilterViewControllerDelegate?
    
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
        
        layout.headerReferenceSize = CGSize(width: collectionView.bounds.width, height: 30)
        
        collectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.className)
        collectionView.register(FilterCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FilterCollectionHeaderView.className)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        applyButton.addTarget(self, action: #selector(didTouchedApplyButton(_:)), for: .touchUpInside)
        
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
        typealias K = IndustryKey.filter
        
        IndustryKey.filter.allCases.forEach { key in
            switch key {
            case .kind:
                let list = dataDistinct(by: "kind")?.compactMap { $0.kind } ?? []
                data.append(list)
                filterKeyList.append(key)
            case .region:
                let list = dataDistinct(by: "region")?.compactMap { $0.region } ?? []
                data.append(list)
                filterKeyList.append(key)
            }
        }
    }
    
    private func setProfessionalData() {
        typealias K = ProfessionalKey.filter
        
        ProfessionalKey.filter.allCases.forEach { key in
            switch key {
            case .kind:
                let list = dataDistinct(by: "kind")?.compactMap { $0.kind } ?? []
                data.append(list)
                filterKeyList.append(key)
            case .region:
                let list = dataDistinct(by: "region")?.compactMap { $0.region } ?? []
                data.append(list)
                filterKeyList.append(key)
            }
        }
    }
    
    private func dataDistinct(by: String) -> Results<T>? {
        return databaseManager().read(T.self)?.distinct(by: [by])
    }
    
    @objc private func didTouchedApplyButton(_ sender: UIButton) {
        delegate?.apply(filter: filterList)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch kind {
        case .Industry:
            return IndustryKey.filter.allCases.count
        case .Professional:
            return ProfessionalKey.filter.allCases.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FilterCollectionHeaderView.className, for: indexPath) as? FilterCollectionHeaderView
            headerView?.update(title: filterKeyList[indexPath.section].keyString)
            return headerView ?? UICollectionReusableView()
        case UICollectionView.elementKindSectionFooter:
            let footerView = UICollectionReusableView()
            return footerView
        default:
            assert(false, "Unexpected element kind")
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.className, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
        cell.update(title: data[indexPath.section][indexPath.row], filterKind: filterKeyList[indexPath.section].key)
        cell.delegate = self
        
        return cell
    }
    
    
    
    func didTouchedTitleButton(_ sender: UIButton, _ filterKind: String) {
        guard let title = sender.currentTitle else { return }
        
        if sender.isSelected {
            filterList[filterKind]?.insert(title)
        } else {
            filterList[filterKind]?.remove(title)
        }
    }
}
