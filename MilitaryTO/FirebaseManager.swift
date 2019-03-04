//
//  FirebaseManager.swift
//  MilitaryTO
//
//  Created by 장혜준 on 05/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import FirebaseDatabase

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
    private var ref: DatabaseReference?
    
    init() {
        self.ref = Database.database().reference()
    }
    
    func getVersionData(success: (() -> Void)? = nil, failure: (() -> Void)? = nil) {
        ref?.child(FirebaseChild.version.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else { return }
            
            FirebaseDatabaseVersion.allCases.forEach {
                value[$0.rawValue]
            }
            
        }, withCancel: { (error) in
            failure?()
        })
    }
    
    func getIndustryData(success: (() -> Void)? = nil, failure: (() -> Void)? = nil) {
        ref?.child(FirebaseChild.industry.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value as? [String: Any] else { return }
            
            
            
            success?()
        }, withCancel: { (error) in
            failure?()
        })
    }
}

func firebaseManager() -> FirebaseManager {
    return FirebaseManager.shared
}
