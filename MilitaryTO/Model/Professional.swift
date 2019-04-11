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
        region <- map[ProfessionalKey.region.keyString]
    }
    
    func toValue(key: ProfessionalKey) -> String? {
        switch key {
        case .idx:
            return String(self.idx)
        case .kind:
            return self.kind
        case .name:
            return self.name
        case .region:
            return self.region
        }
    }
}

enum ProfessionalKey: String, CaseIterable {
    case idx = "연번"
    case kind = "업종"
    case name = "업체명"
    case region = "해당지방병무청"
    
    enum filter: String, CaseIterable, Filter {
        case kind
        case region
        
        var key: String {
            return self.rawValue
        }
        
        var keyString: String {
            switch self {
            case .kind:
                return ProfessionalKey.kind.keyString
            case .region:
                return ProfessionalKey.region.keyString
            }
        }
    }
    
    var keyString: String {
        return self.rawValue
    }
    
    static var detailCases: [ProfessionalKey] {
        return allCases.filter { $0 != .idx && $0 != .name }
    }
}
