//
//  Model.swift
//  MilitaryTO
//
//  Created by 장혜준 on 2018. 4. 10..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Foundation
import RealmSwift

final class TOData: Object {
    @objc dynamic var idx = ""
    @objc dynamic var sector = ""
    @objc dynamic var sacale = ""
    @objc dynamic var name = ""
    @objc dynamic var address = ""
    @objc dynamic var tel = ""
    @objc dynamic var mainProduct = ""
    @objc dynamic var selectionYear = ""
    @objc dynamic var total = ""
    @objc dynamic var before98Three = ""
    @objc dynamic var before98Two = ""
    @objc dynamic var at99Three = ""
    @objc dynamic var reason = ""
    @objc dynamic var local = ""
}
