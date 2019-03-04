//
//  UIView+ext.swift
//  MilitaryTO
//
//  Created by 장혜준 on 04/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

extension UIView {
    func setCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
