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

final class UserListViewController: UIViewController {

    // MARK:- IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK:- Properties

    let viewModel = UserListViewModel()

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
    }

    private func bindingData() {
        let trigger = rx.viewDidAppear.mapTo(()).asDriver(onErrorJustReturn: ())
        let input = UserListViewModel.Input(trigger: trigger)

        let output = viewModel.transform(input: input)
        output.cellViewModels.drive(tableView.rx.items) { tableView, row, cellViewModel in
            let cell = tableView.dequeueReusableCell(withClass: UserTableViewCell.self)
            cell.bind(to: cellViewModel)
            return cell
        }
        .disposed(by: rx.disposeBag)

        output.isLoading.drive(HUD.rx.isAnimating).disposed(by: rx.disposeBag)
    }

}
