//
//  UIColor+ext.swift
//  MilitaryTO
//
//  Created by 장혜준 on 04/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

extension UIColor {
    convenience init(hex: Int, alpha: Double = 1.0) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    class func rgb(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
        return rgba(red, green, blue, 1)
    }
    
    class func rgba(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat) -> UIColor {
        let r = CGFloat(red & 0xFF) / 255.0
        let g = CGFloat(green & 0xFF) / 255.0
        let b = CGFloat(blue & 0xFF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}
