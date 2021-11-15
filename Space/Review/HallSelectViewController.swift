//
//  HallSelectViewController.swift
//  Space
//
//  Created by lina on 2021/11/13.
//

import UIKit

final class HallSelectViewController: UIViewController {

    @IBOutlet private weak var appImageView: UIImageView! {
        didSet {
            appImageView.layer.cornerRadius = 17
        }
    }
    @IBOutlet weak var blackHallButton: UIButton! {
        didSet {
            blackHallButton.layer.cornerRadius = 16
            blackHallButton.layer.borderColor = UIColor(named: "purple01")?.cgColor
        }
    }
    @IBOutlet weak var blackHallCheckImageView: UIImageView!
    @IBOutlet weak var whiteHallButton: UIButton! {
        didSet {
            whiteHallButton.layer.cornerRadius = 16
            whiteHallButton.layer.borderColor = UIColor(named: "purple01")?.cgColor
        }
    }
    @IBOutlet weak var whiteHallCheckImageView: UIImageView!
    @IBOutlet weak var allNameLabel: UILabel!  {
        didSet {
            allNameLabel.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var explainLabel: UILabel! {
        didSet {
            explainLabel.layer.cornerRadius = 12
        }
    }
    @IBOutlet var stars: [UIImageView]!
 
    @IBAction private func didTapBlackHallButton(_ sender: UIButton) {
        setHallButton(isBlackHall: true)
    }
    
    @IBAction private func didTapWhiteHallButton() {
        setHallButton(isBlackHall: false)
    }
    
    private func setHallButton(isBlackHall: Bool) {
        explainLabel.isHidden = false
        stars.forEach { $0.isHidden = false }
        blackHallCheckImageView.isHidden = !isBlackHall
        whiteHallCheckImageView.isHidden = isBlackHall

        if isBlackHall {
            blackHallButton.layer.borderWidth = 4
            whiteHallButton.layer.borderWidth = 0
            explainLabel.text = "블랙홀은 더 이상 사용하지 않는, 또는\n떠나보내주고 싶은 앱이 모여있는 곳이에요."
        } else {
            blackHallButton.layer.borderWidth = 0
            whiteHallButton.layer.borderWidth = 4
            explainLabel.text = "화이트홀은 블랙홀에 있던 앱을 꺼내오거나,\n좋은 경험으로 기념하고 싶은 앱이 모여있는 곳이에요."
        }
    }
}
