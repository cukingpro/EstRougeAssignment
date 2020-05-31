//
//  UITableViewExtensions.swift
//  EstRougeAssignment
//
//  Created by Huy Tong on 5/31/20.
//  Copyright © 2020 Huy Tong. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    /// SwifterSwift: Dequeue reusable UITableViewCell using class name
       ///
       /// - Parameter name: UITableViewCell type
       /// - Returns: UITableViewCell object with associated class name.
       func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
           guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
               fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
           }
           return cell
       }

       /// SwifterSwift: Dequeue reusable UITableViewCell using class name for indexPath
       ///
       /// - Parameters:
       ///   - name: UITableViewCell type.
       ///   - indexPath: location of cell in tableView.
       /// - Returns: UITableViewCell object with associated class name.
       func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
           guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
               fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
           }
           return cell
       }

       /// SwifterSwift: Register UITableViewCell with .xib file using only its corresponding class.
       ///               Assumes that the .xib filename and cell class has the same name.
       ///
       /// - Parameters:
       ///   - name: UITableViewCell type.
       ///   - bundleClass: Class in which the Bundle instance will be based on.
       func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
           let identifier = String(describing: name)
           var bundle: Bundle?

           if let bundleName = bundleClass {
               bundle = Bundle(for: bundleName)
           }

           register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
       }
}
