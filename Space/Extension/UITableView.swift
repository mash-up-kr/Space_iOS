//
//  UITableView.swift
//  Space_iOS
//
//  Created by lina on 2021/10/02.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
        let nib = UINib(nibName: T.reusableIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue a cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }
}
