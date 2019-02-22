//
//  Utility.swift
//  MilitaryTO
//
//  Created by 장혜준 on 20/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

func DEBUG_LOG(_ msg: Any, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
        let fileName = file.split(separator: "/").last ?? ""
        let functionName = function.split(separator: "(").first ?? ""
        print("👻 [\(fileName)] \(functionName)((\(line)) : \(msg)")
    #endif
}

func ERROR_LOG(_ msg: Any, file: String = #file, function: String = #function, line: Int = #line) {
    let fileName = file.split(separator: "/").last ?? ""
    let functionName = function.split(separator: "(").first ?? ""
    print("😡 [\(fileName)] \(functionName)((\(line)) : \(msg)")
}
