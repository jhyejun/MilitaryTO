//
//  ViewController.swift
//  MilitaryTO
//
//  Created by 장혜준 on 2018. 1. 29..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    
    // UI
    
    fileprivate let userIdTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "아이디를 입력해주세요."
        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    fileprivate let userPasswordTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.placeholder = "비밀번호를 입력해주세요."
        $0.isSecureTextEntry = true
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    fileprivate let loginButton = UIButton().then {
        $0.backgroundColor = UIColor.red
        $0.layer.cornerRadius = 5
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        $0.setTitle("로그인", for: .normal)
    }
    
    fileprivate let loginEnableLabel = UILabel().then {
        $0.text = "Not Enable"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor.red
        $0.textAlignment = .center
    }
    
    var loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    
    // View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.addTarget(self, action: #selector(loginButtonTapPrint), for: .touchUpInside)
        
        self.view.addSubview(userIdTextField)
        self.view.addSubview(userPasswordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(loginEnableLabel)
        
        _ = userIdTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.userIdText)
        _ = userPasswordTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.userPasswordText)
        
        _ = loginViewModel.isValid.bind(to: loginButton.rx.isEnabled)
        
        loginViewModel.isValid.subscribe(onNext: { isValid in
            self.loginButton.backgroundColor = isValid ? .green : .red
            self.loginEnableLabel.text = isValid ? "Enabled" : "Not Enabled"
            self.loginEnableLabel.textColor = isValid ? .green : .red
        }).disposed(by: disposeBag)
        
        self.userIdTextField.snp.makeConstraints{ make in
            make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(50)
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(35)
        }
        
        self.userPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(self.userIdTextField.snp.bottom).offset(10)
            make.left.right.height.equalTo(self.userIdTextField)
        }
        
        self.loginButton.snp.makeConstraints { make in
            make.top.equalTo(self.userPasswordTextField.snp.bottom).offset(30)
            make.left.right.equalTo(self.userIdTextField)
            make.height.equalTo(50)
        }
        
        self.loginEnableLabel.snp.makeConstraints { make in
            make.top.equalTo(self.loginButton.snp.bottom).offset(10)
            make.left.right.equalTo(self.userIdTextField)
        }
    }

    
    // Action
    
    @objc func loginButtonTapPrint() {
        print("Enable Tapped")
    }
    
}

