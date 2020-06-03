//
//  UserListViewController.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 5/31/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import SwifterSwift
import UIKit
import RxCocoa
import RxSwift
import RxViewController
import NSObject_Rx
import RxSwiftExt
import Reachability
import SVProgressHUD

final class UserListViewController: UIViewController {

    // MARK:- IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK:- Properties

    let viewModel = UserListViewModel()

    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bindingData()
    }

    // MARK:- Private functions

    private func configUI() {
        configNavigationBar()
        configTableView()
    }

    private func configNavigationBar() {
        title = "User List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic-menu")?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: nil)
    }

    private func configTableView() {
        tableView.register(nibWithCellClass: UserTableViewCell.self)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
    }

    private func bindingData() {
        let trigger = refreshControl.rx.controlEvent(.valueChanged).asDriver().startWith(())
        let selection = tableView.rx.modelSelected(UserTableViewCellViewModel.self).asDriver()
        let input = UserListViewModel.Input(trigger: trigger, selection: selection)

        let output = viewModel.transform(input: input)
        output.cellViewModels.drive(tableView.rx.items) { tableView, row, cellViewModel in
            let cell = tableView.dequeueReusableCell(withClass: UserTableViewCell.self)
            cell.bind(to: cellViewModel)
            return cell
        }
        .disposed(by: rx.disposeBag)

        output.isLoading.drive(SVProgressHUD.rx.isAnimating).disposed(by: rx.disposeBag)
        output.isLoading.skip(1).drive(refreshControl.rx.isRefreshing).disposed(by: rx.disposeBag)

        output.userSelected.drive(onNext: { [weak self] userDetailViewModel in
            let userDetailViewController = UserDetailViewController()
            userDetailViewController.viewModel = userDetailViewModel
            self?.navigationController?.pushViewController(userDetailViewController)
        }).disposed(by: rx.disposeBag)

        output.error.drive(onNext: { [weak self] error in
            self?.showAlert(title: "Error", message: error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }

}
