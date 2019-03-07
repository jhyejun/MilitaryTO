//
//  DatabaseManager.swift
//  MilitaryTO
//
//  Created by 장혜준 on 05/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class DatabaseManager {
    static let shared = DatabaseManager()

    private var realm: Realm? = nil
    
    func initialize() {
        realm = try? Realm()
    }
    
    func read<T: Object>(_ type: T.Type) -> Results<T>? {
        guard let realm = self.realm else {
            ERROR_LOG("realm is nil")
            return nil
        }
        
        return realm.objects(T.self)
    }
    
    func write(_ object: Object) {
        guard let realm = self.realm else {
            ERROR_LOG("realm is nil")
            return
        }
        
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            ERROR_LOG("Failed realm write")
        }
    }
}

func databaseManager() -> DatabaseManager {
    return DatabaseManager.shared
}
