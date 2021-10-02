//
//  HomeAppCell.swift
//  Space
//
//  Created by bran.new on 2021/10/02.
//

import UIKit

final class HomeAppCell: UICollectionViewCell, Reusable {
    @IBOutlet weak var imageView: UIImageView!

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height * 8 / 48
    }
}
