//
//  User.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 6/1/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import ObjectMapper
import RealmSwift

@objcMembers final class User: Object, Mappable {

    dynamic var id: Int = 0
    dynamic var login: String = ""
    dynamic var avatarUrl: String = ""
    dynamic var name: String = ""
    dynamic var location: String = ""
    dynamic var bio: String = ""
    dynamic var htmlUrl: String = ""
    dynamic var publicRepos: Int = 0
    dynamic var followers: Int = 0
    dynamic var following: Int = 0

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

    override class func primaryKey() -> String? {
        return "id"
    }

}
