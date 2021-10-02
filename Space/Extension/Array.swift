//
//  Array.swift
//  Space_iOS
//
//  Created by lina on 2021/10/02.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        get {
            indices ~= index ? self[index] : nil
        }
        set(newValue) {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
