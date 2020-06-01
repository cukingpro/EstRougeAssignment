//
//  UserDetailViewModel.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 6/1/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

final class UserDetailViewModel: ViewModel, ViewModelType, HasDisposeBag {

    struct Input {
        let trigger: Driver<Void>
    }

    struct Output {
        let isLoading: Driver<Bool>
        let name: Driver<String>
        let location: Driver<String>
        let avatarUrl: Driver<String>
        let bio: Driver<String>
        let publicRepos: Driver<String>
        let followers: Driver<String>
        let following: Driver<String>
    }

    let user: BehaviorRelay<User>

    init(user: User) {
        self.user = BehaviorRelay(value: user)
        super.init()
    }

    func transform(input: Input) -> Output {
        input.trigger.withLatestFrom(user.asDriver()).flatMapLatest { user -> Driver<User> in
            self.userService.getUser(login: user.login)
                .trackActivity(self.activityIndicator)
                .asDriver(onErrorJustReturn: User())
        }.drive(user).disposed(by: disposeBag)

        let isLoading = activityIndicator.asDriver()
        let name = user.map({ $0.name }).asDriver(onErrorJustReturn: "")
        let location = user.map({ $0.location }).asDriver(onErrorJustReturn: "")
        let avatarUrl = user.map({ $0.avatarUrl }).asDriver(onErrorJustReturn: "")
        let bio = user.map({ $0.bio }).asDriver(onErrorJustReturn: "")
        let publicRepos = user.map({ $0.publicRepos.string }).asDriver(onErrorJustReturn: "")
        let followers = user.map({ $0.followers.string }).asDriver(onErrorJustReturn: "")
        let following = user.map({ $0.following.string }).asDriver(onErrorJustReturn: "")

        return Output(isLoading: isLoading,
                      name: name,
                      location: location,
                      avatarUrl: avatarUrl,
                      bio: bio,
                      publicRepos: publicRepos,
                      followers: followers,
                      following: following)
    }

    
}
