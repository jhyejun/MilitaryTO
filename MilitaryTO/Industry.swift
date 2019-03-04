//
//  Industry.swift
//  MilitaryTO
//
//  Created by 장혜준 on 26/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

struct Industry {
    var idx: Int?
    var kind: String?
    var scale: String?
    var name: String?
    var location: String?
    var phoneNumber: String?
    var mainSubject: String?
    var selectionYear: String?
    var totalTO: Int?
    var beforeThreeConventionTO: Int?
    var beforeTwoConventionTO: Int?
    var threeConventionTO: Int?
    var isLimit: Bool?
    var region: String?
}

class realmIndustry: Object {
    @objc dynamic var idx: Int = 0
    @objc dynamic var kind: String?
    @objc dynamic var scale: String?
    @objc dynamic var name: String?
    @objc dynamic var location: String?
    @objc dynamic var phoneNumber: String?
    @objc dynamic var mainSubject: String?
    @objc dynamic var selectionYear: String?
    @objc dynamic var totalTO: Int = 0
    @objc dynamic var beforeThreeConventionTO: Int = 0
    @objc dynamic var beforeTwoConventionTO: Int = 0
    @objc dynamic var threeConventionTO: Int = 0
    @objc dynamic var isLimit: Bool = false
    @objc dynamic var region: String?
}
