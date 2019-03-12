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
    private var indicatorBackgroundView: UIView = UIView(frame: UIScreen.main.bounds).then {
        $0.backgroundColor = .rgba(3, 3, 3, 0.6)
    }
    private var indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: .zero)).then {
        $0.type = .ballPulseSync
        $0.color = .flatYellow
    }
    
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
            guard let window = UIApplication.shared.keyWindow else { return }
            
            self.indicatorBackgroundView.addSubview(self.indicator)
            self.indicator.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(50)
            })
            window.addSubview(self.indicatorBackgroundView)
            self.indicator.startAnimating()
        }
    }
    
    func stopAnimating() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.indicatorBackgroundView.removeFromSuperview()
        }
    }
}
