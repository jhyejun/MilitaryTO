//
//  Industry.swift
//  MilitaryTO
//
//  Created by 장혜준 on 26/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import ObjectMapper

protocol KeyToValue {
    associatedtype T
    
    func toValue(key: T) -> String?
}

protocol CustomCase {
    associatedtype T
    
    static var filterCase: [T] { get }
}

class Industry: Military, Mappable, KeyToValue {
    typealias T = IndustryKey
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    @objc dynamic var totalTO: Int = 0
    @objc dynamic var beforeThreeConventionTO: Int = 0
    @objc dynamic var beforeTwoConventionTO: Int = 0
    @objc dynamic var threeConventionTO: Int = 0
    
    override static func primaryKey() -> String? {
        return "idx"
    }
    
    func mapping(map: Map) {
        idx <- map[IndustryKey.idx.keyString]
        kind <- map[IndustryKey.kind.keyString]
        scale <- map[IndustryKey.scale.keyString]
        name <- map[IndustryKey.name.keyString]
        location <- map[IndustryKey.location.keyString]
        phoneNumber <- map[IndustryKey.phoneNumber.keyString]
        mainSubject <- map[IndustryKey.mainSubject.keyString]
        selectionYear <- map[IndustryKey.selectionYear.keyString]
        totalTO <- map[IndustryKey.totalTO.keyString]
        beforeThreeConventionTO <- map[IndustryKey.beforeThreeConventionTO.keyString]
        beforeTwoConventionTO <- map[IndustryKey.beforeTwoConventionTO.keyString]
        threeConventionTO <- map[IndustryKey.threeConventionTO.keyString]
        isLimit <- map[IndustryKey.isLimit.keyString]
        region <- map[IndustryKey.region.keyString]
    }
    
    func toValue(key: IndustryKey) -> String? {
        switch key {
        case .idx:
            return String(self.idx)
        case .kind:
            return self.kind
        case .scale:
            return self.scale
        case .name:
            return self.name
        case .location:
            return self.location
        case .phoneNumber:
            return self.phoneNumber
        case .mainSubject:
            return self.mainSubject == "" ? "알 수 없음" : self.mainSubject
        case .selectionYear:
            return self.selectionYear
        case .totalTO:
            return String(self.totalTO) + "명"
        case .beforeThreeConventionTO:
            return String(self.beforeThreeConventionTO) + "명"
        case .beforeTwoConventionTO:
            return String(self.beforeTwoConventionTO) + "명"
        case .threeConventionTO:
            return String(self.threeConventionTO) + "명"
        case .isLimit:
            return self.isLimit == "" ? "배정제한 없음" : self.isLimit
        case .region:
            return self.region
        }
    }
}

enum IndustryKey: String, CaseIterable {
    case idx = "연번"
    case kind = "업종"
    case scale = "기업규모"
    case name = "업체명"
    case location = "소재지"
    case phoneNumber = "전화번호"
    case mainSubject = "주생산품목"
    case selectionYear = "선정년도"
    case totalTO = "배정인원(현역)-특성화고·마이스터고 졸업생 계"
    case beforeThreeConventionTO = "99년생 이전(3자 협약)"
    case beforeTwoConventionTO = "99년생 이전(2자 협약)"
    case threeConventionTO = "00년생 (3자 협약)"
    case isLimit = "배정제한여부"
    case region = "해당지방병무청"
    
    var keyString: String {
        return self.rawValue
    }
    
    static var filterCases: [IndustryKey] {
        var list: [IndustryKey] = []
        list.append(.kind)
//        list.append(.region)
//        list.append(.totalTO)
        return list
    }
    
    static var detailCases: [IndustryKey] {
        return allCases.filter { $0 != .idx && $0 != .name }
    }
}
