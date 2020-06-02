//
//  UserDetailViewModelTests.swift
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
import RxBlocking

@testable import EstRougeAssignment

final class UserDetailViewModelTests: QuickSpec {
    override func spec() {
        var viewModel: UserDetailViewModel!
        var disposeBag: DisposeBag!
        let user: User = {
            let user = User()
            user.login = "mojombo"
            return user
        }()

        beforeEach {
            viewModel = UserDetailViewModel(user: user)
            disposeBag = DisposeBag()
        }

        afterEach {
            viewModel = nil
            disposeBag = nil
        }

        describe("Test user detail") {
            var trigger: PublishSubject<Void>!
            var input: UserDetailViewModel.Input!
            var output: UserDetailViewModel.Output!

            beforeEach {
                stub(condition: isHost("api.github.com")) { _ in
                    let path: String! = OHPathForFile("User.json", type(of: self))
                    return fixture(filePath: path, status: 200, headers: ["Content-Type":"application/json; charset=utf-8"])
                }
                trigger = PublishSubject<Void>()
                input = UserDetailViewModel.Input(trigger: trigger.asDriver(onErrorJustReturn: ()))
                output = viewModel.transform(input: input)
            }

            afterEach {
                trigger = nil
                input = nil
                output = nil
            }
            
            it("should return correct followers") {
                let followers = PublishSubject<String>()
                output.followers.drive(followers).disposed(by: disposeBag)

                trigger.onNext(())
                expect(try? followers.toBlocking().first()) == "21997"
            }

            it("should return correct following") {
                let following = PublishSubject<String>()
                output.following.drive(following).disposed(by: disposeBag)

                trigger.onNext(())
                expect(try? following.toBlocking().first()) == "11"
            }

            it("should return correct public repos") {
                let publicRepos = PublishSubject<String>()
                output.publicRepos.drive(publicRepos).disposed(by: disposeBag)

                trigger.onNext(())
                expect(try? publicRepos.toBlocking().first()) == "61"
            }
        }
    }
}
