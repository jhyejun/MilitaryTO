//
//  Industry.swift
//  MilitaryTO
//
//  Created by 장혜준 on 26/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import ObjectMapper

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

class IndustryRealm: Object, Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
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
    @objc dynamic var isLimit: String?
    @objc dynamic var region: String?
    
    override static func primaryKey() -> String? {
        return "idx"
    }
    
    func mapping(map: Map) {
        idx <- map["연번"]
        kind <- map["업종"]
        scale <- map["기업규모"]
        name <- map["업체명"]
        location <- map["소재지"]
        phoneNumber <- map["전화번호"]
        mainSubject <- map["주생산품목"]
        selectionYear <- map["선정년도"]
        totalTO <- map["배정인원(현역)-특성화고·마이스터고 졸업생 계"]
        beforeThreeConventionTO <- map["99년생 이전(3자 협약)"]
        beforeTwoConventionTO <- map["99년생 이전(2자 협약)"]
        threeConventionTO <- map["00년생 (3자 협약)"]
        isLimit <- map["배정제한여부"]
        region <- map["해당지방병무청"]
    }
}
