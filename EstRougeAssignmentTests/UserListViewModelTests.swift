//
//  UserListViewModelTests.swift
//  EstRougeAssignmentTests
//
//  Created by Huy Tong on 6/2/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import Foundation
import Quick
import Nimble
import OHHTTPStubs
import RxSwift

@testable import EstRougeAssignment

final class UserListViewModelTests: QuickSpec {

    override func spec() {
        var viewModel: UserListViewModel!
        var disposeBag: DisposeBag!

        beforeEach {
            viewModel = UserListViewModel()
            disposeBag = DisposeBag()
        }

        afterEach {
            viewModel = nil
            disposeBag = nil
        }

        describe("Test number of users") {
            it("should return correct number of users") {
                stub(condition: isHost("api.github.com")) { _ in
                    let path: String! = OHPathForFile("Users.json", type(of: self))
                    return fixture(filePath: path, status: 200, headers: nil)
                }

                let numberOfUsers = PublishSubject<Int>()
                let trigger = PublishSubject<Void>()
                let selection = PublishSubject<UserTableViewCellViewModel>()
                let input = UserListViewModel.Input(trigger: trigger.asDriver(onErrorJustReturn: ()),
                                                    selection: selection.asDriver(onErrorJustReturn: UserTableViewCellViewModel(user: User())))

                let output = viewModel.transform(input: input)
                output.cellViewModels.map({ $0.count })
                    .drive(numberOfUsers)
                    .disposed(by: disposeBag)

                trigger.onNext(())
                expect(try? numberOfUsers.toBlocking().first()) == 30
            }
        }
    }
}
