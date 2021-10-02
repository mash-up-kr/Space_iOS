//
//  AppsBottomSheet.swift
//  Space
//
//  Created by bran.new on 2021/10/02.
//

import UIKit
import PanModal

final class AppsBottomSheet: UIViewController {

    // Subviews
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var bottomSheetBackButton: UIButton! = UIButton()

    // Data
    private var apps: [String] = (0...50).map(String.init)

    private var isViewDidAppear: Bool = false
    var onPanModalWillPresent: (() -> Void)?
    var onPanModalWillDismiss: (() -> Void)?
    var onPanModalWillTransition: ((PanModalPresentationController.PresentationState) -> Void)?

    private var formStyle: PanModalPresentationController.PresentationState = .shortForm

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard isViewDidAppear == false else { return }
        isViewDidAppear = true
        onPanModalWillPresent?()

        bottomSheetBackButton.setImage(UIImage(named: "btn_back_left_12px"), for: .normal)
        bottomSheetBackButton.setTitle("홈으로", for: .normal)
        bottomSheetBackButton.addTarget(self, action: #selector(actionDidTapBottomSheetBackButton), for: .touchUpInside)
        if let window = view.window {
            window.addSubview(bottomSheetBackButton)
            bottomSheetBackButton.translatesAutoresizingMaskIntoConstraints = false
            bottomSheetBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            bottomSheetBackButton.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -34).isActive = true
        }
    }

    @IBOutlet weak var testButton: UIButton!

    private func setupView() {
        titleLabel.text = "나의 화이트홀"

        collectionView.setCollectionViewLayout(shortFormLayout(), animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeAppCell.self)
        collectionView.register(HomeAppAddCell.self)
        collectionView.reloadData()
    }
}

// MARK: - BottomSheetBackButton
extension AppsBottomSheet {
    @objc func actionDidTapBottomSheetBackButton() {
        dismiss(animated: true, completion: nil)
    }
    private func showBottomSheetBackButton(above bottomView: UIView) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4,
                                                       delay: 0,
                                                       options: .curveEaseOut) {
            self.bottomSheetBackButton.alpha = 1
        } completion: { position in

        }
    }
    private func hideBottomSheetBackButton() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.4,
                                                       delay: 0,
                                                       options: .curveEaseOut) {
            self.bottomSheetBackButton.alpha = 0
        } completion: { position in

        }
    }
}

extension AppsBottomSheet: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.formStyle {
        case .shortForm:
            return min(apps.count, 5)
        case .longForm:
            return 1 + apps.count
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.formStyle {
        case .shortForm:
            let cell = collectionView.dequeueReusableCell(for: indexPath) as HomeAppCell
            cell.backgroundColor = getRandomColor()
            return cell
        case .longForm:
            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(for: indexPath) as HomeAppAddCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(for: indexPath) as HomeAppCell
                cell.backgroundColor = getRandomColor()
                return cell
            }
        }
    }

    func getRandomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

extension AppsBottomSheet {
    func shortFormLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 19, bottom: 20, trailing: 19)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    func longFormLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 19, bottom: 20, trailing: 19)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension AppsBottomSheet: PanModalPresentable {
    var panScrollable: UIScrollView? { collectionView }
//    var shortFormHeight: PanModalHeight { .intrinsicHeight }
    var longFormHeight: PanModalHeight { .maxHeightWithTopInset(84) }
    var allowsTapToDismiss: Bool { false }
    var allowsDragToDismiss: Bool { false }
    var showDragIndicator: Bool { false }
    var panModalBackgroundColor: UIColor { .clear }
    var isUserInteractionEnabled: Bool { true }
    var transitionDuration: Double { 0.3 }

    var shortFormHeight: PanModalHeight {
        guard let scrollView = panScrollable
            else { return .maxHeight }

        // called once during presentation and stored
        scrollView.layoutIfNeeded()
        return .contentHeight(28 + 37 + scrollView.contentSize.height)
    }

    func willTransition(to state: PanModalPresentationController.PresentationState) {
        guard self.formStyle != state else { return }
        onPanModalWillTransition?(state)
        formStyle = state
        collectionView.reloadData()
        panModalSetNeedsLayoutUpdate()
    }

    func panModalWillDismiss() {
        onPanModalWillDismiss?()
    }
}
