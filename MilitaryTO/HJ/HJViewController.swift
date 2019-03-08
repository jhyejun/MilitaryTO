//
//  HJViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 04/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class HJViewController: UIViewController {
    lazy var indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: UIScreen.main.bounds,
                                                                          type: .ballRotateChase,
                                                                          color: .flatYellow,
                                                                          padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func startAnimating() {
        DispatchQueue.main.async {
            self.indicator.startAnimating()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
}
