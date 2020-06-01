//
//  UserTarget.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 6/1/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import Moya

enum UserTarget {
    case getUsers
    case getUser(login: String)
}

extension UserTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }

    var path: String {
        switch self {
        case .getUsers:
            return "users"
        case .getUser(let login):
            return "users/\(login)"
        }
    }

    var method: Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return nil
    }
}
