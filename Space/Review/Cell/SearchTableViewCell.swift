//
//  SearchTableViewCell.swift
//  Space
//
//  Created by lina on 2021/11/13.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var appImageView: UIImageView! {
        didSet {
            appImageView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    
    func configuerCell(imageURL: String, name: String) {
        appImageView.image = UIImage(named: "splash_planet")
        appImageView.backgroundColor = UIColor(named: "purple02")
        nameLabel.text = name
    }
}
