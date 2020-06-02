//
//  RealmManager.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 6/2/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import Foundation
import RealmSwift

typealias RealmCompletion = (RealmManager.RealmResult) -> Void

final class RealmManager {

    private init() { }

    static let shared = RealmManager()

    private let realm: Realm? = {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let url = documentDirectory.appendingPathComponent("MyRealm.realm")
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            Realm.Configuration.defaultConfiguration = config
            return try Realm(fileURL: url)
        } catch {
            return nil
        }
    }()
}

extension RealmManager {

    // MARK: - Functions
    
    func write(_ closesure: () -> Void, completion: ((RealmResult) -> Void)? = nil) {
        realm?.beginWrite()
        closesure()
        do {
            try realm?.commitWrite()
            completion?(.success)
        } catch {
            realm?.cancelWrite()
            completion?(.failure(error))
        }
    }

    func fetchObjects<T: Object>(_ type: T.Type, filter predicate: NSPredicate? = nil) -> Results<T>? {
        guard let predicate = predicate else {
            return realm?.objects(type)
        }
        return realm?.objects(type).filter(predicate)
    }

    func fetchObject<T: Object>(_ type: T.Type, filter predicate: NSPredicate? = nil) -> T? {
        let results = fetchObjects(type, filter: predicate)
        return results?.first
    }

    func add<T: Object>(object: T, completion: ((RealmResult) -> Void)? = nil) {
        write({
            realm?.add(object, update: .all)
        }, completion: completion)
    }

    func add<T: Object>(objects: [T], completion: ((RealmResult) -> Void)? = nil) {
        write({
            realm?.add(objects, update: .all)
        }, completion: completion)
    }
}

extension RealmManager {

    enum RealmResult {
        case success
        case failure(Error)
    }
}

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
