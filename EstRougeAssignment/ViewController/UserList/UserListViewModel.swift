//
//  UserListViewModel.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 5/31/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import Foundation
import RxCocoa

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
        let cellViewModels = input.trigger.flatMapLatest { [unowned self] _ -> Driver<[User]> in
            return self.userService.getUsers().trackActivity(self.activityIndicator).asDriver(onErrorJustReturn: [])
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
