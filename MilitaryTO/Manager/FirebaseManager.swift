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
    case database_current_version
    case database_old_version
    case app_current_version
    case app_old_version
    case app_update_message
}

class FirebaseManager {
    static let shared = FirebaseManager()
    private var ref: DatabaseReference? = nil
    
    func initialize() {
        self.ref = Database.database().reference()
    }
    
    func getVersionData(success: (() -> Void)? = nil, failure: (() -> Void)? = nil) {
        ref?.child(FirebaseChild.version.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let data = snapshot.value as? [String: String] else { return }
            FirebaseDatabaseVersion.allCases.forEach {
                if $0 == .database_current_version {
                    
                }
                
                let test = data[$0.rawValue]
            }
            
//            guard let self = self, let data = snapshot.value as? [String: Any] else { return }
//
//            if let databaseVersion = data["database_current_version"] as? Int {
//                if databaseVersion > myUserDefaults.integer(forKey: "database_version") {
//                    myUserDefaults.set(databaseVersion, forKey: "database_version")
//                } else {
//                    self.presentList(sender.titleLabel?.text, .Industry)
//                }
//            }
            
        }, withCancel: { (error) in
            ERROR_LOG(error.localizedDescription)
            failure?()
        })
    }
    
    func getIndustryData(success: (() -> Void)? = nil, failure: (() -> Void)? = nil) {
        ref?.child(FirebaseChild.industry.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let data = snapshot.value as? [[String: Any]] else { return }
            
            data.forEach {
                if let object = Mapper<IndustryRealm>().map(JSON: $0) {
                    databaseManager().write(object)
                }
            }
            
            success?()
        }, withCancel: { (error) in
            ERROR_LOG(error.localizedDescription)
            failure?()
        })
    }
}

func firebaseManager() -> FirebaseManager {
    return FirebaseManager.shared
}
