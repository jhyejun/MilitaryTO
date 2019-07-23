//
//  ListTableViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 26/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class ListTableViewController<T: Military>: HJViewController, UITableViewDelegate, UITableViewDataSource, FilterViewControllerDelegate {
    private let searchTextField: UITextField = UITextField().then {
        $0.placeholder = "업체명 검색"
        $0.font = $0.font?.withSize(15)
        $0.setLeftPadding(10)
        $0.setCornerRadius(5)
        $0.setBorder(color: .flatGray, width: 0.5)
    }
    private let filterButton: UIButton = UIButton().then {
        $0.setTitle("필터", for: .normal)
        $0.setTitleColor(.flatBlack, for: .normal)
        $0.setTitleColor(.flatWhite, for: .selected)
        $0.titleLabel?.font = $0.titleLabel?.font.withSize(15)
        $0.setCornerRadius(5)
        $0.setBorder(color: .flatForestGreenDark, width: 0.5)
    }
    private let tableView: HJTableView = HJTableView().then {
        $0.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        $0.separatorStyle = .singleLine
        $0.tableFooterView = UIView()
    }
    private let emptyLabel: UILabel = UILabel().then {
        $0.text = "검색 결과가 없습니다."
        $0.textColor = .flatBlack
        $0.font = $0.font.withSize(20)
        $0.isHidden = true
    }

    private var navigationTitle: String?
    private var data: [T]?
    private var kind: MilitaryServiceKind
    private var filterList: [String: Set<String>] = [:]

    private let disposeBag: DisposeBag = DisposeBag()

    init(_ title: String? = nil, _ kind: MilitaryServiceKind) {
        self.navigationTitle = title
        self.data = databaseManager().read(T.self)?.compactMap { $0 as T }
        self.kind = kind

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        searchTextField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        filterButton.addTarget(self, action: #selector(touchedFilterButton(_:)), for: .touchUpInside)

        searchTextField.rx.controlEvent(.editingChanged)
            .asObservable()
            .map {
                guard let text = self.searchTextField.text else { return }
                return text
            }
            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { name in
                if name.isEmpty {
                    self.data = databaseManager().read(T.self)?.compactMap { $0 as T }
                    self.dataFiltered()
                    self.tableView.reloadData()
                }
            })
            .filter { $0.isNotEmpty }
            .subscribe(onNext: { [weak self] (name) in
                guard let self = self else { return }
                
                self.data = self.data?.filter { $0.name?.contains(name) ?? false }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)

        tableView.delegate = self
        tableView.dataSource = self

        addSubViews(views: [searchTextField, filterButton, tableView, emptyLabel])
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.title = navigationTitle

        filterButton.isSelected = filterList.isNotEmpty

        if filterButton.isSelected {
            filterButton.backgroundColor = .flatForestGreenDark
            filterButton.setBorder(color: .flatBlack, width: 0.5)
        } else {
            filterButton.backgroundColor = .white
            filterButton.setBorder(color: .flatForestGreenDark, width: 0.5)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        searchTextField.endEditing(true)
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
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottomMargin.equalToSuperview()
        }

        emptyLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(tableView)
            make.centerY.equalToSuperview().multipliedBy(0.7)
        }
    }

    @objc func textFieldEditingChanged(_ sender: UITextField) {
        sender.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .do(onNext: { (name) in
                if name.isEmpty {
                    self.data = databaseManager().read(T.self)?.compactMap { $0 as T }
                    self.dataFiltered()
                    self.tableView.reloadData()
                }
            })
            .filter { $0.isNotEmpty }
            .subscribe(onNext: { [weak self] (name) in
                guard let self = self else { return }

                self.data = self.data?.filter { $0.name?.contains(name) ?? false }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }

    @objc func touchedFilterButton(_ sender: UIButton) {
        let vc = FilterViewController<T>(kind: kind, filterList: filterList)
        vc.delegate = self
        push(viewController: vc)
    }

    private func dataFiltered() {
        switch kind {
        case .Industry:
            filterList.forEach { key, value in
                switch key {
                case IndustryKey.filter.kind.key:
                    data = data?.filter {
                        guard let kind = $0.kind else { return false }
                        return value.contains(kind)
                    }
                case IndustryKey.filter.region.key:
                    data = data?.filter {
                        guard let region = $0.region else { return false }
                        return value.contains(region)
                    }
//                case .totalTO:
//                    data = data?.filter {
//                        guard let industry = $0 as? Industry,
//                            let filterTO = Int(filterList[key.rawValue]?.first ?? "") else { return false }
//                        return industry.totalTO >= filterTO
//                    }
                default:
                    break
                }
            }
        case .Professional:
            filterList.forEach { key, value in
                switch key {
                case ProfessionalKey.filter.kind.key:
                    data = data?.filter {
                        guard let kind = $0.kind else { return false }
                        return value.contains(kind)
                    }
                case ProfessionalKey.filter.region.key:
                    data = data?.filter {
                        guard let region = $0.region else { return false }
                        return value.contains(region)
                    }
                default:
                    break
                }
            }
        }
    }


    // TableView Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.data {
            tableView.isHidden = data.isEmpty
            emptyLabel.isHidden = data.isNotEmpty
        }

        return data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = data?[indexPath.row] {
            let cell = ListTableViewCell<T>(data: data, kind: kind)
            cell.updateCell()

            return cell
        } else {
            assertionFailure("ListTableViewController : data?[indexPath.row] is nil")
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = data?[indexPath.row] {
            let vc = DetailViewController(data, kind)
            push(viewController: vc)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchTextField.endEditing(true)
    }


    func apply(filter: [String: Set<String>]) {
        guard filter.isNotEmpty, filter.values.isNotEmpty else {
            filterList.removeAll()
            data = databaseManager().read(T.self)?.compactMap { $0 as T }
            tableView.reloadData()
            tableView.scrollToRow(at: NSIndexPath(row: 0, section: 0) as IndexPath, at: .top, animated: false)
            return
        }
        guard filterList != filter else { return }
        data = databaseManager().read(T.self)?.compactMap { $0 as T }
        filterList = filter

        dataFiltered()

        tableView.reloadData()
    }
}
