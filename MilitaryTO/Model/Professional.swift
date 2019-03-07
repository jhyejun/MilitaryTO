//
//  Professional.swift
//  MilitaryTO
//
//  Created by 장혜준 on 07/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import ObjectMapper

class Professional: Object, Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    @objc dynamic var idx: Int = 0
    
    override static func primaryKey() -> String? {
        return "idx"
    }
    
    func mapping(map: Map) {
        idx <- map[ProfessionalKey.idx.keyString]
    }
}

enum ProfessionalKey: String {
    case idx = "연번"
    
    var keyString: String {
        return self.rawValue
    }
}
