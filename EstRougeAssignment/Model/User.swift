//
//  User.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 6/1/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import ObjectMapper

final class User: Mappable {
    var id: Int = 0
    var login: String = ""
    var avatarUrl: String = ""
    var name: String = ""
    var location: String = ""
    var bio: String = ""
    var htmlUrl: String = ""
    var publicRepos: Int = 0
    var followers: Int = 0
    var following: Int = 0

    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        login <- map["login"]
        avatarUrl <- map["avatar_url"]
        name <- map["name"]
        location <- map["location"]
        bio <- map["bio"]
        htmlUrl <- map["html_url"]
        publicRepos <- map["public_repos"]
        followers <- map["followers"]
        following <- map["following"]
    }
}
