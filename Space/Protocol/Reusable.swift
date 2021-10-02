//
//  Reusable.swift
//  Space_iOS
//
//  Created by lina on 2021/10/02.
//

import Foundation

protocol Reusable {
    static var reusableIdentifier: String { get }
}

extension Reusable {
    static var reusableIdentifier: String {
        return "\(self)"
    }
}
