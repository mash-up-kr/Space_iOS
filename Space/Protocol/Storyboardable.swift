//
//  Storyboardable.swift
//  Space
//
//  Created by bran.new on 2021/10/02.
//

import UIKit

protocol Storyboardable where Self: UIViewController {
    static func storyboardInstance() -> Self
}

extension Storyboardable {
    static func storyboardInstance() -> Self {
        return UIStoryboard(name: String(describing: self), bundle: nil).instantiateInitialViewController() as! Self
    }
}

extension UIViewController: Storyboardable {}
