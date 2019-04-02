//
//  Professional.swift
//  MilitaryTO
//
//  Created by 장혜준 on 07/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import ObjectMapper

class Professional: Military, Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "idx"
    }
    
    func mapping(map: Map) {
        idx <- map[ProfessionalKey.idx.keyString]
    }
}

enum ProfessionalKey: String, CaseIterable {
    case idx = "연번"
    
    var keyString: String {
        return self.rawValue
    }
    
    static var cases: [ProfessionalKey] {
        return allCases
    }
}
