//
//  DatabaseManager.swift
//  MilitaryTO
//
//  Created by 장혜준 on 05/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import ObjectMapper

class DatabaseManager {
    static let shared = DatabaseManager()

    private var realm: Realm? = nil
    
    func initialize() {
        realm = try? Realm()
    }
    
    func read<T: Military>(_ type: T.Type) -> Results<T>? {
        guard let realm = self.realm else {
            ERROR_LOG("realm is nil")
            return nil
        }
        
        return realm.objects(T.self)
    }
    
    func write(_ object: Military) {
        guard let realm = self.realm else {
            ERROR_LOG("realm is nil")
            return
        }
        
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            ERROR_LOG("Failed realm write object")
        }
    }
    
    func write(_ objects: [Military]) {
        guard let realm = self.realm else {
            ERROR_LOG("realm is nil")
            return
        }
        
        do {
            for object in objects {
                try realm.write {
                    realm.add(object, update: true)
                }
            }
        } catch {
            ERROR_LOG("Failed realm write objects")
        }
    }
    
    func delete(_ object: Military) {
        guard let realm = self.realm else {
            ERROR_LOG("realm is nil")
            return
        }
        
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            ERROR_LOG("Failed realm delete")
        }
    }
    
    private func delete<T: Military>(_ type: T.Type) {
        guard let realm = self.realm else {
            ERROR_LOG("realm is nil")
            return
        }
        
        if let object = read(T.self) {
            try? realm.write {
                realm.delete(object)
            }
            DEBUG_LOG("\(T.className()) delete success")
        } else {
            DEBUG_LOG("\(T.className()) object is nil")
        }
    }
    
    func deleteAll() {
        guard let realm = self.realm else {
            ERROR_LOG("realm is nil")
            return
        }
        
        do {
            try realm.write {
                realm.deleteAll()
            }
            DEBUG_LOG("delete success")
        } catch {
            ERROR_LOG("Failed realm deleteAll")
        }
    }
    
    func isEmpty<T: Military>(_ type: T.Type) -> Bool {
        if let data = read(T.self), data.isNotEmpty {
            return false
        } else {
            return true
        }
    }
    
    func isNotEmpty<T: Military>(_ type: T.Type) -> Bool {
        return !isEmpty(T.self)
    }
}

func databaseManager() -> DatabaseManager {
    return DatabaseManager.shared
}

extension DatabaseManager {
    func industryObjectWrite(_ data: [[String: Any]]) {
        data.map { Mapper<Industry>().map(JSON: $0) }
            .compactMap { $0 }
            .forEach { databaseManager().write($0) }
    }
    
    func industryObjectDelete() {
        delete(Industry.self)
    }
    
    func professionalObjectWrite(_ data: [[String: Any]]) {
        data.map { Mapper<Professional>().map(JSON: $0) }
            .compactMap { $0 }
            .forEach { databaseManager().write($0) }
    }
    
    func professionalObjectDelete() {
        delete(Professional.self)
    }
}
