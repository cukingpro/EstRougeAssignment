//
//  UserListViewModel.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 5/31/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import Foundation
import RxCocoa
import Reachability
import RxSwift
import RealmSwift

final class UserListViewModel: ViewModel, ViewModelType {

    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<UserTableViewCellViewModel>
    }

    struct Output {
        let isLoading: Driver<Bool>
        let cellViewModels: Driver<[UserTableViewCellViewModel]>
        let userSelected: Driver<UserDetailViewModel>
    }

    func transform(input: Input) -> Output {
        let cellViewModels = input.trigger
            .flatMapLatest { _ -> Driver<[User]> in
                let reachability = try! Reachability()
                let isReachable = reachability.connection != .unavailable
                if isReachable {
                    return UserService.shared.getUsers()
                        .trackActivity(self.activityIndicator)
                        .asDriver(onErrorJustReturn: [])
                        .do(onNext: { users in
                            RealmManager.shared.add(objects: users)
                        })
                } else {
                    return UserRealmService.shared.getUsers()
                        .trackActivity(self.activityIndicator)
                        .asDriver(onErrorJustReturn: [])
                }
            }.map({ users in
                users.map({ user in
                    UserTableViewCellViewModel(user: user)
                })
            })

        let loading = activityIndicator.asDriver()

        let userSelected = input.selection.map({ UserDetailViewModel(user: $0.user) })

        return Output(isLoading: loading,
                      cellViewModels: cellViewModels,
                      userSelected: userSelected)
    }
}
