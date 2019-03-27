//
//  ListTableViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 26/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class ListTableViewController<T: Military>: HJViewController, UITableViewDelegate, UITableViewDataSource {
    private let searchTextField: UITextField = UITextField().then {
        $0.placeholder = "업체명 검색"
        $0.setLeftPadding(10)
        $0.setCornerRadius(5)
        $0.setBorder(color: .flatGray, width: 0.5)
    }
    private let filterButton: UIButton = UIButton().then {
        $0.setTitle("필터", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setCornerRadius(5)
        $0.backgroundColor = .rgb(0, 122, 255)
    }
    private let tableView: HJTableView = HJTableView().then {
        $0.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: -8)
        $0.separatorStyle = .none
    }
    private let emptyLabel: UILabel = UILabel().then {
        $0.text = "검색 결과가 없습니다."
        $0.textColor = .flatBlack
        $0.font = $0.font.withSize(20)
        $0.isHidden = true
    }
    
    private var data: [T]?
    private var kind: MilitaryServiceKind?
    
    private let disposeBag: DisposeBag = DisposeBag()

    init(_ title: String? = nil, _ kind: MilitaryServiceKind) {
        super.init(nibName: nil, bundle: nil)
        
        self.navigationItem.title = title
        self.data = databaseManager().read(T.self)?.compactMap { $0 as T }
        self.kind = kind
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubViews(views: [searchTextField, filterButton, tableView, emptyLabel])
        setConstraints()
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        searchTextField.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(8)
        }
        
        filterButton.setContentHuggingPriority(UILayoutPriority.init(rawValue: 500), for: .horizontal)
        filterButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(searchTextField)
            make.leading.equalTo(searchTextField.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.width.greaterThanOrEqualTo(UIScreen.main.bounds.width * 0.16)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchTextField.snp.bottom)
            make.leading.trailing.bottomMargin.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints { (make) in
            make.center.equalTo(tableView)
        }
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        sender.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { $0.isNotEmpty }
            .subscribe { [weak self] eventString in
                guard let self = self, let text = eventString.element else { return }
                self.data = self.data?.filter { $0.name?.contains(text) ?? false }
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    
    // TableView Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ListTableViewCell<T>(data: data?[indexPath.row], kind: kind)
        cell.updateCell()
        
        return cell
    }
}
