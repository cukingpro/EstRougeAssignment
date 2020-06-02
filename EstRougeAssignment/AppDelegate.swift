//
//  AppDelegate.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 5/31/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import UIKit
import SVProgressHUD
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var reachability: Reachability?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configHUD()
        configReachability()
        setupRootViewController()
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

    private func configReachability() {
        reachability = try? Reachability()
        try? reachability?.startNotifier()
    }
}

