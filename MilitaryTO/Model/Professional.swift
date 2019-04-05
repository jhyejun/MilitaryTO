//
//  Professional.swift
//  MilitaryTO
//
//  Created by 장혜준 on 07/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import ObjectMapper

class Professional: Military, Mappable, KeyToValue {
    typealias T = ProfessionalKey
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "idx"
    }
    
    func mapping(map: Map) {
        idx <- map[ProfessionalKey.idx.keyString]
        kind <- map[ProfessionalKey.kind.keyString]
        name <- map[ProfessionalKey.name.keyString]
    }
    
    func toValue(key: ProfessionalKey) -> String? {
        switch key {
        case .idx:
            return String(self.idx)
        case .kind:
            return self.kind
        case .name:
            return self.name
        }
    }
}

enum ProfessionalKey: String, CaseIterable {
    case idx = "연번"
    case kind = "업종"
    case name = "업체명"
    
    var keyString: String {
        return self.rawValue
    }
    
    static var filterCases: [ProfessionalKey] {
        var list: [ProfessionalKey] = []
        list.append(.kind)
        return list
    }
    
    static var detailCases: [ProfessionalKey] {
        return allCases.filter { $0 != .idx && $0 != .name }
    }
}
