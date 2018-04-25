//
//  convert.swift
//  MilitaryTO
//
//  Created by 장혜준 on 2018. 4. 10..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Foundation
import CSV
import Realm
import RealmSwift

func convert(result: (Bool) -> Void) {
    let filepath = InputStream(fileAtPath: Bundle.main.path(forResource: "2018_TO", ofType: "csv")!)!
    let filedata = try! CSVReader(stream: filepath)
    
    while let row = filedata.next() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.create(TOData.self, value: [row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12], row[13]])
        }
    }
    
    result(true)
}
