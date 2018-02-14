//
//  LoginViewModel.swift
//  MilitaryTO
//
//  Created by 장혜준 on 2018. 2. 9..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel {
    
    var userIdText = Variable<String>("")
    var userPasswordText = Variable<String>("")
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(userIdText.asObservable(), userPasswordText.asObservable()) { email, password in
            email.count >= 3 && password.count >= 6
        }
    }
    
}
