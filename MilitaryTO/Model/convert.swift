//
//  convert.swift
//  MilitaryTO
//
//  Created by 장혜준 on 2018. 4. 10..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Foundation
import CSV

func convert() {
    let filepath = InputStream(fileAtPath: Bundle.main.path(forResource: "2018_TO", ofType: "csv")!)!
    let filedata = try! CSVReader(stream: filepath)
    
    while let row = filedata.next() {
        print("\(row)")
    }
}
