//
//  HomeViewController.swift
//  Space
//
//  Created by bran.new on 2021/10/02.
//

import UIKit

class HomeViewController: UIViewController {

    enum State {
        case idle
        case whitehall
        case myPlanet
        case blackhall
    }

    // Subviews
    @IBOutlet weak var whitehallButton: UIButton!
    @IBOutlet weak var myPlanetButton: UIButton!
    @IBOutlet weak var blackhallButton: UIButton!

    // Animation
    private lazy var blackhallAnimation: UIViewPropertyAnimator = {
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn) { [weak self] in
            guard let self = self else { return }
            let diffX = self.view.center.x - self.blackhallButton.frame.midX
            let diffY = self.view.center.y - self.blackhallButton.frame.midY

            self.whitehallButton.transform = CGAffineTransform(translationX: diffX * 2, y: diffY * 2).scaledBy(x: 2, y: 2)
            self.myPlanetButton.transform = CGAffineTransform(translationX: diffX * 2, y: diffY * 2).scaledBy(x: 2, y: 2)

            self.blackhallButton.transform = CGAffineTransform(translationX: diffX, y: diffY).scaledBy(x: 2, y: 2)
        }
        animator.addCompletion { position in
            switch position {
            case .start:
                break
            case .current:
                break
            case .end:
                self.state = .blackhall
            }
        }
        return animator
    }()

    // State
    private var state: State = .idle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        blackhallButton.addTarget(self, action: #selector(actionDidTapBlackhall), for: .touchUpInside)
    }
}

// MARK: - Actions
extension HomeViewController {
    @objc func actionDidTapBlackhall() {
        guard state != .blackhall else { return }
        blackhallAnimation.startAnimation()
    }
}
