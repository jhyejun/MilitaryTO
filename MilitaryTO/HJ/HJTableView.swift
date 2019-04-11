//
//  HJTableView.swift
//  MilitaryTO
//
//  Created by 장혜준 on 04/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class HJTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        super.reloadData()
        scrollTop()
    }
    
    func scrollTop() {
        if numberOfRows(inSection: 0) > 1 {
            scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
}
