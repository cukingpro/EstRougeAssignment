//
//  UserListViewController.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 5/31/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import UIKit

final class UserListViewController: UIViewController {

    // MARK:- IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK:- Private functions

    private func configTableView() {
        tableView.register(nibWithCellClass: UserTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension UserListViewController: UITableViewDelegate {

}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }


}
