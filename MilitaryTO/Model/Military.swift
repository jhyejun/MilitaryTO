//
//  Military.swift
//  MilitaryTO
//
//  Created by 장혜준 on 27/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

protocol KeyToValue {
    associatedtype T
    
    func toValue(key: T) -> String?
}

protocol Filter {
    var key: String { get }
    var keyString: String { get }
}

class Military: Object {
    @objc dynamic var idx: Int = 0
    @objc dynamic var kind: String?
    @objc dynamic var scale: String?
    @objc dynamic var name: String?
    @objc dynamic var location: String?
    @objc dynamic var phoneNumber: String?
    @objc dynamic var mainSubject: String?
    @objc dynamic var selectionYear: String?
    @objc dynamic var isLimit: String?
    @objc dynamic var region: String?
}
