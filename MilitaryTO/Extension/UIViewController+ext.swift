//
//  UIViewController+ext.swift
//  MilitaryTO
//
//  Created by 장혜준 on 13/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

extension UIViewController {
    func present(builder: AlertBuilder, animated: Bool = true, completion: (() -> Void)? = nil) {
        present(builder.controller, animated: animated, completion: completion)
    }
}
