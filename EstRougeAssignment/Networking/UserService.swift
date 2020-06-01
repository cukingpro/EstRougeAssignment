//
//  UserService.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 6/1/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_ObjectMapper

final class UserService {

    // MARK: - Properties

    let provider = MoyaProvider<UserTarget>()

    // MARK: - Functions

    func getUsers() -> Single<[User]> {
        return provider.rx.request(.getUsers).mapArray(User.self)
    }

    func getUser(login: String) -> Single<User> {
        return provider.rx.request(.getUser(login: login)).mapObject(User.self)
    }
}
