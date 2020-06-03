//
//  UserDetailViewController.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 6/1/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class UserDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var bioLabel: UILabel!
    @IBOutlet private weak var publicRepoLabel: UILabel!
    @IBOutlet private weak var followersLabel: UILabel!
    @IBOutlet private weak var followingLabel: UILabel!

    // MARK: - Properties

    var viewModel: UserDetailViewModel!

    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bindingData()
    }

    // MARK: - Private functions
    
    private func configUI() {
        configNavigationBar()
        configScrollView()
    }

    private func configNavigationBar() {
        title = "Profile"
        let backButton = UIBarButtonItem(image: UIImage(named: "ic-back")?.withRenderingMode(.alwaysOriginal),
                                         style: .plain,
                                         target: navigationController,
                                         action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButton
    }

    private func configScrollView() {
        scrollView.refreshControl = refreshControl
    }

    private func bindingData() {
        let trigger = refreshControl.rx.controlEvent(.valueChanged).asDriver().startWith(())
        let input = UserDetailViewModel.Input(trigger: trigger)

        let output = viewModel.transform(input: input)
        output.avatarUrl.drive(onNext: { [weak self] url in
            if let url = URL(string: url) {
                self?.avatarImageView.af.setImage(withURL: url)
            }
        }).disposed(by: rx.disposeBag)
        output.isLoading.drive(SVProgressHUD.rx.isAnimating).disposed(by: rx.disposeBag)
        output.isLoading.skip(1).drive(refreshControl.rx.isRefreshing).disposed(by: rx.disposeBag)
        output.name.drive(nameLabel.rx.text).disposed(by: rx.disposeBag)
        output.location.drive(locationLabel.rx.text).disposed(by: rx.disposeBag)
        output.bio.drive(bioLabel.rx.text).disposed(by: rx.disposeBag)
        output.publicRepos.drive(publicRepoLabel.rx.text).disposed(by: rx.disposeBag)
        output.followers.drive(followersLabel.rx.text).disposed(by: rx.disposeBag)
        output.following.drive(followingLabel.rx.text).disposed(by: rx.disposeBag)
        output.error.drive(onNext: { [weak self] error in
            self?.showAlert(title: "Error", message: error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }
}
