//
//  HomeViewController.swift
//  Space
//
//  Created by bran.new on 2021/10/02.
//

import UIKit
import Combine
import CoreMotion
import PanModal

class HomeViewController: UIViewController {

    typealias ViewModel = HomeViewModel

    // Subviews
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var whitehallButton: UIButton!
    @IBOutlet weak var myPlanetButton: UIButton!
    @IBOutlet weak var blackhallButton: UIButton!
    private var presentingBottomSheet: UIViewController?

    // Data
    private var viewModel = ViewModel()
    private var motionManager: CMMotionManager = CMMotionManager()

    // Others
    private var subscriptions: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBind()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startMotionHandling()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        stopMotionHandling()
    }

    private func setupView() {
        scrollView.setContentOffset(CGPoint(x: scrollView.contentSize.width/2, y: 0), animated: false)

        myPlanetButton.transform = CGAffineTransform(rotationAngle: .pi / 4)

        whitehallButton.addTarget(self, action: #selector(actionDidTapWhitehall), for: .touchUpInside)
        blackhallButton.addTarget(self, action: #selector(actionDidTapBlackhall), for: .touchUpInside)
    }

    private func setupBind() {
        viewModel.state.bottomSheet
            .removeDuplicates()
            .sink { [weak self] navigation in
                guard let self = self else { return }
                switch navigation {
                case .idle:
                    self.idleAnimation.startAnimation()
                    self.presentingBottomSheet?.dismiss(animated: true)
                case .whitehall:
                    self.presentWhitehall()
                case .myPlanet:
                    break
                case .blackhall:
                    self.presentBlackhall()
                }
            }.store(in: &subscriptions)
    }

    private func startMotionHandling() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (accData: CMAccelerometerData?, error: Error?) -> Void in
                guard let self = self else { return }
                guard let accX: Double = accData?.acceleration.x else { return }
                let isLeft: Bool = (accX.sign == .minus)
                let diff = CGFloat(isLeft ? max(accX, -1.0) : min(accX, 1.0))
//                print(diff)
                var targetX = max(0, self.scrollView.contentOffset.x + diff * 6)
                targetX = min(targetX, self.scrollView.contentSize.width)
                let newTarget = CGPoint(x: targetX, y: 0)
                self.scrollView.setContentOffset(newTarget, animated: true)
            }
        }
    }
    private func stopMotionHandling() {
        motionManager.stopAccelerometerUpdates()
    }
}

// MARK: - BottomSheet
extension HomeViewController {
    private func presentWhitehall() {
        let whitehallAnimation = whitehallAnimation
        whitehallAnimation.addCompletion { [weak self] position in
            guard let self = self else { return }
            guard position == .end else { return }
            let appsBottomSheet = AppsBottomSheet.storyboardInstance(title: "나의 화이트홀")
            appsBottomSheet.onPanModalWillDismiss = { [weak self] in
                self?.viewModel.action.send(.didTapBackButton)
            }
            self.presentPanModal(appsBottomSheet)
            self.presentingBottomSheet = appsBottomSheet
        }
        whitehallAnimation.startAnimation()
    }
    private func presentBlackhall() {
        let blackhallAnimation = blackhallAnimation
        blackhallAnimation.addCompletion { [weak self] position in
            guard let self = self else { return }
            guard position == .end else { return }
            let appsBottomSheet = AppsBottomSheet.storyboardInstance(title: "나의 블랙홀")
            appsBottomSheet.onPanModalWillDismiss = { [weak self] in
                self?.viewModel.action.send(.didTapBackButton)
            }
            self.presentPanModal(appsBottomSheet)
            self.presentingBottomSheet = appsBottomSheet
        }
        blackhallAnimation.startAnimation()
    }
}

// MARK: - Actions
extension HomeViewController {
    @objc func actionDidTapWhitehall() {
        viewModel.action.send(.didTapWhitehall)
    }
    @objc func actionDidTapBlackhall() {
        viewModel.action.send(.didTapBlackhall)
    }
}

// MARK: - Animation
extension HomeViewController {
    var blackhallAnimation: UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) { [weak self] in
            guard let self = self else { return }
            let diffX = self.view.center.x - self.blackhallButton.frame.midX
            let diffY = self.view.center.y - self.blackhallButton.frame.midY
            self.backgroundImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.whitehallButton.transform = CGAffineTransform(translationX: diffX * 2, y: diffY * 2).scaledBy(x: 2, y: 2)
            self.myPlanetButton.transform = CGAffineTransform(translationX: diffX * 2, y: diffY * 2).scaledBy(x: 2, y: 2).rotated(by: .pi / 4)
            self.blackhallButton.transform = CGAffineTransform(translationX: diffX, y: diffY).scaledBy(x: 2, y: 2)
        }
        return animator
    }
    var whitehallAnimation: UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) { [weak self] in
            guard let self = self else { return }
            let diffX = self.view.center.x - self.whitehallButton.frame.midX
            let diffY = self.view.center.y - self.whitehallButton.frame.midY
            self.backgroundImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.whitehallButton.transform = CGAffineTransform(translationX: diffX, y: diffY).scaledBy(x: 2, y: 2)
            self.myPlanetButton.transform = CGAffineTransform(translationX: diffX * 2, y: diffY * 2).scaledBy(x: 2, y: 2).rotated(by: .pi / 4)
            self.blackhallButton.transform = CGAffineTransform(translationX: diffX * 2, y: diffY * 2).scaledBy(x: 2, y: 2)
        }
        return animator
    }
    var idleAnimation: UIViewPropertyAnimator {
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) { [weak self] in
            guard let self = self else { return }
            self.backgroundImageView.transform = .identity
            self.whitehallButton.transform = .identity
            self.myPlanetButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
            self.blackhallButton.transform = .identity
        }
        return animator
    }
}
