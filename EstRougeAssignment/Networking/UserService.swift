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

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

final class UserService {

    private init() { }

    static let shared = UserService()

    // MARK: - Properties

    let provider = MoyaProvider<UserTarget>(
        plugins: [
            NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter),
                                                     logOptions: .verbose))
        ]
    )

    // MARK: - Functions

    func getUsers() -> Single<[User]> {
        return provider.rx.request(.getUsers).mapArray(User.self)
    }

    func getUser(login: String) -> Single<User> {
        return provider.rx.request(.getUser(login: login)).mapObject(User.self)
    }
}
