//
//  FirebaseManager.swift
//  MilitaryTO
//
//  Created by 장혜준 on 05/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import FirebaseDatabase
import ObjectMapper

enum FirebaseChild: String {
    case version
    case industry
    case professional
}

enum FirebaseDatabaseVersion: String, CaseIterable {
    case industry_database_version
    case professional_database_version
    case app_version
    case app_update_message
}

class FirebaseManager {
    static let shared = FirebaseManager()
    private var ref: DatabaseReference? = nil
    
    func initialize() {
        self.ref = Database.database().reference()
    }
    
    func getVersionData(completion: @escaping ([String: Any]?) -> Void) {
        ref?.child(FirebaseChild.version.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let data = snapshot.value as? [String: Any] else { return }
            completion(data)
        }, withCancel: { (error) in
            ERROR_LOG(error.localizedDescription)
            completion(nil)
        })
    }
    
    func getIndustryData(completion: @escaping ([[String: Any]]?) -> Void) {
        ref?.child(FirebaseChild.industry.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let data = snapshot.value as? [[String: Any]] else { return }
//            databaseManager().industryObjectWrite(data)
            completion(data)
        }, withCancel: { (error) in
            ERROR_LOG(error.localizedDescription)
            completion(nil)
        })
    }
}

func firebaseManager() -> FirebaseManager {
    return FirebaseManager.shared
}

extension FirebaseManager {
    func isNeedToUpdateDatabaseVersion(_ version: Float) -> Bool {
        if version > myUserDefaults.float(forKey: "industry_database_version") {
            myUserDefaults.set(version, forKey: "industry_database_version")
            return true
        } else {
            return false
        }
    }
    
    func updateDatabaseVersion(_ data: [String: Any]) {
        FirebaseDatabaseVersion.allCases.forEach {
            if let floatValue = data[$0.rawValue] as? Float {
                myUserDefaults.set(floatValue, forKey: $0.rawValue)
            } else if let stringValue = data[$0.rawValue] as? String {
                myUserDefaults.set(stringValue, forKey: $0.rawValue)
            }
        }
    }
}
