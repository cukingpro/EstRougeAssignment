//
//  UserRealmService.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 6/2/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import Foundation
import RxSwift

final class UserRealmService {

    private init() { }

    static let shared = UserRealmService()

    // MARK: - Functions

    func getUsers() -> Single<[User]> {
        let users = RealmManager.shared.fetchObjects(User.self)?.toArray(type: User.self) ?? []
        return Single.just(users)
    }

    func getUser(login: String) -> Single<User> {
        let predicate = NSPredicate(format: "login = %@", "\(login)")
        let user = RealmManager.shared.fetchObject(User.self, filter: predicate) ?? User()
        return Single.just(user)
    }
}
