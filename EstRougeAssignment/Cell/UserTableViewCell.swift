//
//  UserTableViewCell.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 5/31/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import UIKit
import AlamofireImage
import RxSwift

class UserTableViewCell: UITableViewCell {

    // MARK: - IBOutlets

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var htmlUrlLabel: UILabel!

    // MARK: - Functions

    func bind(to viewModel: UserTableViewCellViewModel) {
        viewModel.login.bind(to: nameLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.htmlUrl.bind(to: htmlUrlLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.avatarUrl.subscribe(onNext: { [weak self] url in
            if let url = URL(string: url) {
                self?.avatarImageView.af.setImage(withURL: url)
            }
        }).disposed(by: rx.disposeBag)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        var mutatingSelf = self
        mutatingSelf.rx.disposeBag = DisposeBag()
        avatarImageView.image = nil
    }
    
}
