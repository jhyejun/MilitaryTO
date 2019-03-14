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
    private var indicatorLabel: UILabel = UILabel().then {
        $0.text = "데이터를 받아오는 중입니다 ....\n업데이트가 끝나기 전까지 기다려주세요!"
        $0.textColor = .white
        $0.font = $0.font.withSize(17)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    private var indicatorBackgroundView: UIView = UIView(frame: UIScreen.main.bounds).then {
        $0.backgroundColor = .rgba(3, 3, 3, 0.9)
    }
    private var indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(origin: .zero, size: .zero)).then {
        $0.type = .ballPulseSync
        $0.color = .flatYellow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .flatBlack
        
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
            self.indicatorBackgroundView.addSubview(self.indicatorLabel)
            self.indicator.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(50)
            })
            self.indicatorLabel.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.indicator)
                make.top.equalTo(self.indicator.snp.bottom).offset(30)
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
