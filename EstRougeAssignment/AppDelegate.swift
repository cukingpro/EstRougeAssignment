//
//  AppDelegate.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 5/31/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import UIKit
import SVProgressHUD

typealias HUD = SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        configHUD()
        return true
    }

}

extension AppDelegate {

    private func setupRootViewController() {
        let viewController = UserListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    private func configHUD() {
        SVProgressHUD.setDefaultMaskType(.black)
    }
}

