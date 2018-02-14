//
//  SearchViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 2018. 2. 13..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // UI
    
    fileprivate let companySearchBar = UISearchBar().then {
        $0.backgroundColor = .black
        $0.barStyle = .black
        $0.barTintColor = .white
        $0.placeholder = "검색하세요."
    }
    
    fileprivate let resultTableView = UITableView(frame: .zero, style: UITableViewStyle.plain).then {
        $0.backgroundColor = .white
        $0.alwaysBounceVertical = true
        $0.separatorStyle = .none
        $0.register(SearchResultCell.self, forCellReuseIdentifier: "resultCell")
    }
    
    
    // View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultTableView.delegate = self
        self.resultTableView.dataSource = self
        
        self.view.addSubview(companySearchBar)
        self.view.addSubview(resultTableView)
        
        self.companySearchBar.snp.makeConstraints { make in
            make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.resultTableView.snp.makeConstraints { make in
            make.top.equalTo(self.companySearchBar.snp.bottom)
            make.left.right.equalTo(self.companySearchBar)
            make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
        }
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! SearchResultCell
        cell.selectionStyle = .none
        
        return cell
    }
    
}
