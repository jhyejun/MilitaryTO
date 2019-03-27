//
//  UITextField+ext.swift
//  MilitaryTO
//
//  Created by 장혜준 on 27/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

extension UITextField {
    func setLeftPadding(_ padding: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
