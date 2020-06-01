//
//  UserTableViewCellViewModel.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 6/1/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class UserTableViewCellViewModel {

    // MARK: - Properties

    let user: User

    let login: BehaviorRelay<String>
    let htmlUrl: BehaviorRelay<String>
    let avatarUrl: BehaviorRelay<String>

    init(user: User) {
        self.user = user
        login = BehaviorRelay(value: user.login)
        htmlUrl = BehaviorRelay(value: user.htmlUrl)
        avatarUrl = BehaviorRelay(value: user.avatarUrl)
    }
}
