//
//  Global.swift
//  MilitaryTO
//
//  Created by 장혜준 on 04/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

let myUserDefaults = UserDefaults.standard

func compareDatabaseVersion(_ newValue: Int) -> Bool {
    let result = newValue > myUserDefaults.integer(forKey: "database_version")
    
    if result {
        myUserDefaults.set(newValue, forKey: "database_version")
    }
    
    return result
}
