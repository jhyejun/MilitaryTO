//
//  DetailViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 2018. 4. 4..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var sectorLabel: UILabel!
    @IBOutlet weak var scaleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telLabel: UILabel!
    @IBOutlet weak var mainProductLabel: UILabel!
    @IBOutlet weak var selectionYearLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var before98ThreeLabel: UILabel!
    @IBOutlet weak var before98TwoLabel: UILabel!
    @IBOutlet weak var at99ThreeLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    
    var sector: String = ""
    var scale: String = ""
    var name: String = ""
    var address: String = ""
    var tel: String = ""
    var mainProduct: String = ""
    var selectionYear: String = ""
    var total: String = ""
    var before98Three: String = ""
    var before98Two: String = ""
    var at99Three: String = ""
    var reason: String = ""
    var local: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sectorLabel.text = sector
        scaleLabel.text = scale
        nameLabel.text = name
        addressLabel.text = address
        telLabel.text = tel
        mainProductLabel.text = mainProduct
        selectionYearLabel.text = selectionYear
        totalLabel.text = total == "" ? "0" : total
        before98ThreeLabel.text = before98Three == "" ? "0" : before98Three
        before98TwoLabel.text = before98Two == "" ? "0" : before98Two
        at99ThreeLabel.text = at99Three == "" ? "0" : at99Three
        reasonLabel.text = reason
        localLabel.text = local
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

}
