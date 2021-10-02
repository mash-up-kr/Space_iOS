//
//  HomeAppAddCell.swift
//  Space
//
//  Created by bran.new on 2021/10/03.
//

import UIKit

final class HomeAppAddCell: UICollectionViewCell, Reusable {

    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height * 8 / 48
    }
}
