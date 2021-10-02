//
//  UICollectionView.swift
//  Space_iOS
//
//  Created by lina on 2021/10/02.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        let nib = UINib(nibName: T.reusableIdentifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reusableIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue a cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }
}
